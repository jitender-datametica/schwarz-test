CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_REF_CLIENT_LEAD
AS
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017  -                 Generiert aus Teradata
#  1.1  15.11.2017  Wieber,Harald     Release 1.1
#  1.2  17.01.2018  Wieber,Harald     Release 2.2
#  1.3  09.10.2018  J. Graeff         20181009_1854_RS_Korrektur_Landesnamen
#                                     correct US and RS value for country_opening_date
#  1.3  2018-10-09    Joerg  Gräff    adapt country_opening_date for serbia and us
#                                     20181009_1854_RS_Korrektur_Landesnamen
#  1.4  06.08.2020    Roy, Ritanjal   Introduce new country Latviya
#  1.5  17.12.2021  Michael Morris    Added Estonia EE
#  1.6  23.08.2024  Malec, Marcin     Added column vs_sort, with an additional country sorting logic; User Story 665161
#----------------------------------------------------------------------------
*/
SELECT   int_id
       , country_id AS client_id  /* Referenzierung des Landes                                          */
       , country_iso_cd           /* Country ISO_Code, Landeskürzel                                     */
       , country_group_id         /* techn. DWH- Schlüssel zur Referenzierung der Vorstandsregion       */
       , lisy_sort                /* Sortierung aus dem Vorsystem Lisy                                  */
       , vs_sort                  /* VS sort                                                            */
       , dashboard_relevant_fg    /* Für Lead Dashboard relevant                                        */
       , country_desc_AT
       , country_desc_BE
       , country_desc_BG
       , country_desc_CH
       , country_desc_CY
       , country_desc_CZ
       , country_desc
       , country_desc_DK
       , country_desc_EE
       , country_desc_ES
       , country_desc_FI
       , country_desc_FR
       , country_desc_GB
       , country_desc_GR
       , country_desc_HR
       , country_desc_HU
       , country_desc_IE
       , country_desc_IT
       , country_desc_LT
       , country_desc_NI
       , country_desc_NL
       , country_desc_DE
       , country_desc_LV
       , country_desc_PL
       , country_desc_PT
       , country_desc_RO
       , country_desc_SE
       , country_desc_SI
       , country_desc_SK
       , country_desc_CS
       , country_desc_MT
       , country_desc_US
       , country_desc_RS
       , CASE client_id WHEN 23 THEN '1973'
                        WHEN 12 THEN '04/1989'
                        WHEN 18 THEN '03/1992'
                        WHEN 10 THEN '04/1994'
                        WHEN 13 THEN '11/1994'
                        WHEN  2 THEN '04/1995'
                        WHEN 25 THEN '07/1995'
                        WHEN 22 THEN '10/1997'
                        WHEN  1 THEN '11/1998'
                        WHEN 21 THEN '05/1999'
                        WHEN 14 THEN '06/1999'
                        WHEN 17 THEN '07/2000'
                        WHEN 24 THEN '04/2002'
                        WHEN 11 THEN '08/2002'
                        WHEN  6 THEN '06/2003'
                        WHEN 27 THEN '09/2003'
                        WHEN 29 THEN '09/2004'
                        WHEN 16 THEN '11/2004'
                        WHEN  8 THEN '09/2005'
                        WHEN 15 THEN '11/2006'
                        WHEN 28 THEN '03/2007'
                        WHEN 32 THEN '04/2008'
                        WHEN  4 THEN '03/2009'
                        WHEN 31 THEN '02/2010'
                        WHEN 26 THEN '01/2010'
                        WHEN  3 THEN '01/2010'
                        WHEN  5 THEN '11/2010'
                        WHEN 19 THEN '03/2016'
                        WHEN 33 THEN '01/2017'
                        WHEN 34 THEN '03/2018'
                        WHEN 20 THEN '04/2021'
                        WHEN  9 THEN '03/2022'
                        ELSE '01/1900'
          END AS country_opening_date
  FROM P_LEW_MART_MSI.v_ref_country_lead
;