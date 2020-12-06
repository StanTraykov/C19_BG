# C19_BG

Набор скриптове за генериране на COVID-19 графики от отворените данни на България и EUROSTAT/НСИ.

## Инсталация / Употреба

#### 1. Уверете се, че ползвате актуална версия на R и инсталирайте необходимите пакети:

```R
install.packages("tidyverse", "geofacet", "zoo", "EpiEstim")
```

#### 2. Изтеглете файловете от GitHub

За изтегляне може да ползвате зеления бутон в GitHub: Code -> Download ZIP (разархивирайте в директория по ваш избор).

#### 3. Изтеглете данни от портала за "отворени" данни

Изтеглете ръчно трите файла ``Обща статистика за разпространението.csv``, ``Разпределение по дата и по възрастови групи.csv``, ``Разпределение по дата и по области.csv`` от https://data.egov.bg/data/view/492e8186-0d00-43fb-8f5e-f2b0b183b64f и ги сложете в папката ``data``. (Данните от EUROSTAT скриптовете теглят сами и също поставят в тази директория.)
 
#### 4. Влезте в директорията в R (``getwd()``, ``setwd("...")``) или отворете ``C19_BG.Rproj`` в RStudio.

Оттам има няколко начина да се генерират графики:

##### 4.1. Просто и бързо:  генериране на SVG, с команди save_all():
```R
source("R/heat.R"); save_all()
source("R/var_plot.R"); save_all()
source("R/oblasts.R"); save_all()
source("R/demo.R"); save_all()
```
За генериране на R-графиката, първо трябва да се изчисли R:

```R
source("R/estR.R")
source("R/r_plot.R"); save_all()
```
##### 4.2 Сложно и бавно: растеризация с Inkscape и JPEG компресия с ImageMagick

Отворете файла ``output_all.R`` в папка R и нагласете пътищата към Inscape и ImageMagick (трябва да ги имате инсталирани предварително). След това изпълнете:

```R
source("R/output_all.R")
```

##### 4.3 Ръчно

Можете да промени функциите ``save_all()`` във файловете или ръчно да изведете резултатите на екран или запишете в SVG/PNG/JPG (последнтие със загуба на качество спрямо бавния вариант по-горе). Например:

```R
source("R/var_plot.R")
my_plot <- var_plot("age", roll_func = mean, roll_window = 7, line_legend = "0")
# екран
plot(my_plot)
# файл
ggsave(file = "my_plot.png", width = 11, height = 7, plot = my_plot)
```
*Забележка: При проблеми с UNICODE в RStudio под Windows, изпълнете ръчно ``source("...")`` БЕЗ аргумент ``encoding = 'UTF-8'``, който се добавя автоматично от RStudio.*

### Пакет?

Скриптовете не се предлагат като пакет по технически причини. Не знам как да заобиколя лошата UNICODE поддръжка на R под Windows (става само с хакване и изглежда ще трябва поддръжка на отделни пакети за различни платфортми, което не бих искал да правя). В момента скриптовете работят при мен под Windows.

## Уики

* [Методика за изчисление на R](https://github.com/StanTraykov/C19_BG/wiki/%D0%9C%D0%B5%D1%82%D0%BE%D0%B4%D0%B8%D0%BA%D0%B0-%D0%B7%D0%B0-%D0%B8%D0%B7%D1%87%D0%B8%D1%81%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BD%D0%B0-R)
