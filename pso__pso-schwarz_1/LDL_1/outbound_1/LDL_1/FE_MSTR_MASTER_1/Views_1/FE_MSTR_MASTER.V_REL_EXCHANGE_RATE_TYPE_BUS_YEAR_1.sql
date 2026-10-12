CREATE OR REPLACE VIEW fe_mstr_master.v_rel_exchange_rate_type_bus_year_1 (exchange_rate_type_cd
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'),
exchange_bus_year
OPTIONS(description='Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.'),
exchange_rate_type_descr
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.'),
exchange_rate_type_descr_de
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in German.'),
exchange_rate_type_descr_en
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in English.'),
rel_exchange_rate_type_descr
OPTIONS(description='A textual description combined with bus. year for the way in which one currency can be converted into another expressed in group language, i.e. in German.'),
rel_exchange_rate_type_descr_de
OPTIONS(description='A textual description combined with bus. year for the way in which one currency can be converted into another expressed in German.'),
rel_exchange_rate_type_descr_en
OPTIONS(description='A textual description combined with bus. yearfor the way in which one currency can be converted into another expressed in English.'))
OPTIONS(DESCRIPTION = `CURRENCY EXCHANGE RATES. FOR A GIVEN PAIR OF CURRENCIES THERE MIGHT BE SEVERAL EXCHANGE RATE TYPES. SOME OF THEM MIGHT BE VALID FOR AN ENTIRE BUSINESS YEAR.`)
AS SELECT MAIN.exchange_rate_type_cd,
 MAIN.bus_year AS exchange_bus_year,
 RATE.exchange_rate_type_descr,
 RATE.exchange_rate_type_descr_de,
 RATE.exchange_rate_type_descr_en,
   CAST(MAIN.bus_year AS STRING) || ' ' || RATE.exchange_rate_type_descr AS rel_exchange_rate_type_descr,
   CAST(MAIN.bus_year AS STRING) || ' ' || RATE.exchange_rate_type_descr_de AS rel_exchange_rate_type_descr_de,
   CAST(MAIN.bus_year AS STRING) || ' ' || RATE.exchange_rate_type_descr_en AS rel_exchange_rate_type_descr_en
FROM ldl_data_core_dim.t_fact_exchange_rate_1 AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_exchange_rate_type_1 AS RATE ON MAIN.exchange_rate_type_cd = RATE.exchange_rate_type_cd
  
GROUP BY MAIN.exchange_rate_type_cd,
 exchange_bus_year,
 RATE.exchange_rate_type_descr,
 RATE.exchange_rate_type_descr_de,
 RATE.exchange_rate_type_descr_en;