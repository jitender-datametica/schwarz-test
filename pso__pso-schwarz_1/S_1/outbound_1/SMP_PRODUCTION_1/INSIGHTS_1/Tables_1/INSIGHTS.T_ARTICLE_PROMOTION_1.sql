CREATE OR REPLACE TABLE smp_production_insights.t_article_promotion_1 (
division_id STRING(100) OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) OPTIONS(description='Country_1 iso code'),
gtin_id STRING(500) OPTIONS(description='gtin/article'),
gtin_name STRING(1000) OPTIONS(description='name of gtin/article'),
promotion_id STRING(100) OPTIONS(description='identifier of promotion'),
start_date DATE OPTIONS(description='start date of the promotion'),
end_date DATE OPTIONS(description='end date of the promotion'),
days INTEGER OPTIONS(description='number of days of the promotion duration'),
category STRING(1000) OPTIONS(description='categorie of the gtin/article'),
category_name STRING(1000) OPTIONS(description='category name of the gtin/article')
);