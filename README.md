# Уеб страница
Графиките са достъпни на https://stantraykov.github.io/C19_BG/

# Ако сте един от тях... 
Ако работите за държавата и имате нещо общо с обработката и публикацията на COVID-19 данни, изпълнете гражданския си дълг и станете whistleblower. Кой нарежда данните да се крият? Защо българското население да няма достъп до елементарни показатели? Такива са смъртните случаи по възрастови групи и по области, разбивка на тестването по поръчител (държавни с подкатегории, частни), хоспитализации/интензивни (по прием, средни интервали до смърт/изписване), данни преди юни (колкото има и каквито има) и т.н.

# C19_BG
Набор скриптове за генериране на COVID-19 графики от отворените данни на България и EUROSTAT/НСИ.

## Инсталация / употреба

### 1. Уверете се, че ползвате актуална версия на R и инсталирайте необходимите пакети:

```R
install.packages(c("tidyverse", "geofacet", "ggrepel", "zoo", "scales", "EpiEstim", "shadowtext", "R.utils", "httr"))
```

### 2. Изтеглете файловете от GitHub

За изтегляне може да ползвате зеления бутон в GitHub: Code -> Download ZIP (разархивирайте в директория по ваш избор).

### 3. Генерирайте графиките

Влезте в папката на скриптовете в R (``getwd()``, ``setwd("...")``) или отворете ``C19_BG.Rproj`` в RStudio. Оттам има няколко начина да се генерират графики:

*Забележка: Скриптовете теглят данни от data.egov.bg, EUROSTAT и ECDC и ги поставят в папка* `data`*. Изтрийте файловете* `demo_r_mwk_10.tsv.gz`, `ecdc_*.csv.gz`, `bg_*.csv` *от папка* `data`*, ако желаете данните да се обновят.*

#### 3.1. Просто и бързо:  генериране на SVG с команди ``save_all()``:
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
#### 3.2 Сложно и бавно: растеризация с Inkscape и JPEG компресия с ImageMagick

Отворете файла ``output_all.R`` в папка R и нагласете пътищата към Inkscape и ImageMagick (трябва да ги имате инсталирани предварително). След това изпълнете:

```R
source("R/output_all.R")
```

#### 3.3 С ваш код

Можете да промените функциите ``save_all()`` във файловете или ръчно да изведете резултатите на екран / запишете в SVG/PNG/JPEG формати (последните два със загуба на качество спрямо бавния вариант по-горе). Например:

```R
source("R/var_plot.R")
my_plot <- var_plot("age", roll_func = mean, roll_window = 7, line_legend = "0")
# екран
plot(my_plot)
# файл
ggsave(file = "my_plot.png", width = 11, height = 7, plot = my_plot)
```
*Забележка: При проблеми с Unicode в RStudio под Windows, изпълнете ръчно* ``source("...")`` *БЕЗ аргумент* ``encoding = 'UTF-8'``*, който се добавя автоматично от RStudio.*

## Пакет?

Скриптовете не се предлагат като пакет по технически причини. Не знам как да заобиколя лошата UNICODE поддръжка на R под Windows (става само с хакване и изглежда ще трябва поддръжка на отделни пакети за различни платфортми, което не бих искал да правя). В момента скриптовете работят при мен под Windows.

## Уики

* [Методика за изчисление на R](https://github.com/StanTraykov/C19_BG/wiki/%D0%9C%D0%B5%D1%82%D0%BE%D0%B4%D0%B8%D0%BA%D0%B0-%D0%B7%D0%B0-%D0%B8%D0%B7%D1%87%D0%B8%D1%81%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BD%D0%B0-R)
