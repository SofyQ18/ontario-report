2+2
library(tidyverse)
sample_data <- read_csv("sample_data.csv")
sum(5, 6)
read_csv(file = 'sample_data.csv') # reads in csv file

ggplot(data=sample_data)

ggplot(data = sample_data) +
  aes(x = temperature) #aes: comando eje x

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") #labs: nombre de eje - x

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml) +
  labs(y = "Cells per mL") +
  geom_point()

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml) +
  labs(y = "Cells per mL") +
  geom_point() +
  labs(title = "Does temperature affect microbial abundance?")

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml) +
  labs(y = "Cells per mL") +
  geom_point() +
  labs(title = "Does temperature affect microbial abundance?") +
  aes(color = env_group) #coloree segun ambiente, otra variable

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml) +
  labs(y = "Cells per mL") +
  geom_point() +
  labs(title = "Does temperature affect microbial abundance?") +
  aes(color = env_group) +
  aes(size = chlorophyll)

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml) +
  labs(y = "Cells per mL") +
  geom_point() +
  labs(title = "Does temperature affect microbial abundance?") +
  aes(color = env_group) +
  aes(size = chlorophyll) +
  labs(size = "Chlorophyll (ug/L)",
       color = "Environmental Group")

ggplot(data = sample_data) +
  aes(x = temperature) +
  labs(x = "Temperature (C)") +
  aes(y = cells_per_ml/1000000) +
  labs(y = "Cells (millions/mL)") +
  geom_point() +
  labs(title = "Does temperature affect microbial abundance?") +
  aes(color = env_group) +
  aes(size = chlorophyll) +
  labs(size = "Chlorophyll (ug/L)",
       color = "Environmental Group")

#diagrama de caja y bigotes
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot()

#diagrama de violín
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_violin()

ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot()

ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot() +
  geom_point()

ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot() +
  geom_jitter()

ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot() +
  geom_jitter(aes(size = chlorophyll))

#caja de bigotes + contorno rosa
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot(color="pink")

#caja de bigotes + relleno rosa
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot(fill="pink")

#colores por variable
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot(aes(fill=env_group))

#color seleccionado por variable
ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot(aes(fill=env_group)) +
  scale_fill_manual(values = c("pink", "tomato","orange1"))

#color segun paletas de colores
graph1 <- ggplot(data = sample_data) +
  aes(x = env_group, y = cells_per_ml) +
  geom_boxplot(aes(fill=env_group)) +
  scale_fill_brewer(palette = "Set1")

ggsave("graph1.jpg", width = 6, height = 4)

ggsave("awesome_boxplot.jpg", width =6, height =4)

