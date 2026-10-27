buoy_data <- read_csv("buoy_data.csv") #leer archivos

head(buoy_data) #muestra las primeras columnas

#hacer un gráfico de puntos, eje x día del año, eje y: temperatura, profundidad hacerlo con color
ggplot(data = buoy_data) +
  aes(x=day_of_year, y=temperature, color=depth) +
  geom_point()

#lo mismo, pero gráfico de barras
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, color = depth) +
  geom_line()

#los mismo, pero gráfico de líneas
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, group = sensor, color = depth) +
  geom_line()

ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, group = sensor, color = buoy) +
  geom_line()

#4 gráficos en uno.
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, group = sensor, color = depth) +
  geom_line() + 
  facet_wrap(~buoy)

#4 gráficos apilados
ggplot(data = buoy_data) +
  aes(x = day_of_year, y = temperature, group = sensor, color = depth) +
  geom_line() + 
  facet_grid(rows = vars(buoy))




