# Vein Framework
Framework for data processing and transport

Based on Qt framework

## Logging options
```C++

QStringList loggingFilters = QStringList() << QString("*.debug=false"); // ... << QString("*.warning=false") ...
QLoggingCategory::setFilterRules(loggingFilters.join("\n"));

```

