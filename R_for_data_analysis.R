library(tidyverse)

# cargar los datos
sample_data <- read_csv("data/sample_data.csv")

# promedio de abundancia de celulas
summarize(sample_data, average_cells=mean(cells_per_ml))

# Podemos usar el %>% pipe operator para pasarle el argumento a summarize tambien
sample_data %>% summarize(average_cells=mean(cells_per_ml))

# Esto nos permite juntar multiples funciones, pasando el output de la izquierda
# como input de la derecha, tambien podemos juntar multiples parametros

sample_data %>%
  filter(env_group == "Deep") %>% # aqui juntando funciones
  summarize(average_cells = mean(cells_per_ml), # aqui juntando parametros
            by = NULL) 
  
# pueden intentar el ejercicio

# group_by() nos da un filter() por valor de variable
sample_data %>%
  group_by(env_group) %>%
  summarize(average=mean(cells_per_ml))
# Pueden intentar calcular la temperatura por grupo
# summarize puede hacer mas de una columna, pasandole otro valor (parametro) 
# separado por una coma
sample_data %>%
  group_by(env_group) %>%
  summarize(average=mean(cells_per_ml), min=min(cells_per_ml))
# mutate puede crear nuevas columnas para usar como hemos hecho con cells_per_ml
sample_data %>%
  mutate(tn_tp_ratio = total_nitrogen / total_phosphorus)
# Filter seleccionaba un subset de filas pero podemos usar select 
# Cuando queremos seleccionar un subset de columnas de nuestra data
sample_data %>%
  select(sample_id, depth) 
# Tambien podemos seleccionar todas excepto x al poner un "-" al frente
sample_data %>%
  select(-env_group)


# Limpiando datos
taxon_dirty <- read_csv("data/taxon_abundance.csv")
# Podemos verla con view dentro de R e inferar lo que esta mal desde ahi, tambien
# lo pueden abrir desde fuera con excel y ver
# view(taxon_dirty)
# Da error porque la primera fila no son las variables de las columnas
taxon_dirty <- read_csv("data/taxon_abundance.csv", skip=2)

# Ahora tiene un problema adicional donde la columna 10 esta vacia y la 9 tiene
# informacion del secuenciador
taxon_dirty <- read_csv("data/taxon_abundance.csv", skip=2) %>%
  select(-...10) %>%
  rename(sequencer = ...9)
head(taxon_dirty, 6)
# finalmente vamos a eliminar las ultimas columnas y dejar solo los taxones limpios
taxon_clean <- taxon_dirty %>% 
  select(sample_id:Cyanobacteria) #escoge todo lo anterior a Cyanobacteria
# pueden leer de formatos, vamos a cambiarlo a long
taxon_long <- taxon_clean %>%
  pivot_longer(cols = Proteobacteria:Cyanobacteria, 
               names_to = "Phylum",
               values_to = "Abundance")

taxon_long 
# pueden ver el cambio de formato
# Ayuda a trabajar mejor con ggplot2 y dplyr (se lleva con group_by())
taxon_long %>%
  group_by(Phylum) %>%
  summarize(avg_abund = mean(Abundance))
# ggplot (no suma 1 pq faltan phyla)
taxon_long %>%
  ggplot(aes(x = sample_id, y = Abundance, fill = Phylum)) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90))
# por ejemplo para ver nuestra data en formato wide
taxon_long %>%
  pivot_wider(names_from = "Phylum", values_from = "Abundance")
# Ahora podemos unir nuestro taxon y sample data pq comparten el mismo sample_id
head(sample_data, 6)
head(taxon_clean, 6)
# uniendoles con dplyr (podemos poner cual columna usar si queremos con , by =)
inner_join(sample_data, taxon_clean)

# Hay menos columnas en el final por que faltan muestras en taxon_clean
# podemos ver las columnas que estan en la izquierda y no en la derecha con anti_join 
anti_join(sample_data, taxon_clean, by="sample_id")

# podemos inv mas, usando $ para extraer una columna de nuestra data
sample_data$sample_id
taxon_clean$sample_id
# Parece que las muestras usaron September y Sep, toca estandarizar
taxon_clean_goodSept <- taxon_clean %>%
  mutate(sample_id = str_replace(sample_id, pattern = "Sep", replacement = "September"))
# hacemos que todas ssean September y unimos
sample_and_taxon <- inner_join(sample_data, taxon_clean_goodSept, by = "sample_id")
# Ahora guardamos nuestra nueva metadata combinada
write_csv(sample_and_taxon, "data/sample_and_taxon.csv")

# Pueden hacer los graficos restantes para meter al reporte si quieren
ggplot(sample_and_taxon, aes(x=total_nitrogen,y=cells_per_ml)) +
  geom_point() +
  facet_wrap(~env_group)
sample_and_taxon %>% 
  filter(env_group == "Shallow_May") %>% 
  arrange(desc(total_nitrogen))
view(sample_and_taxon)
