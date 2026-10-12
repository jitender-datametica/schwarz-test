--==============================================================
-- Table: wbs_l_estimation
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_estimation
   generated from Powerdesigner on Dienstag, 9. Januar 2024 09:34:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_l_estimation (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
estimation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.            ID 0 = no estimation            ID 1 = calculate normal estimation process            ID 2 = only fill up maximum capacity (Berechnung für die Werbung in WBS, aber nur um das Regal aufzufüllen)'),
estimation_bez STRING(100) OPTIONS(description='Description of the ESTIMATION_ID.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, estimation_id) NOT ENFORCED
)
OPTIONS(description='With this lookup table, the user can define how the estimation (promotion calculation) for an article should take place.             - 0 = no estimation (e.g. articles which are decentral and where the people in the stores are ordering manually)             - 1 = normal estimation-process (e.g. normal assortment, high volumes, articles from DC)             - 2 = refill maximum shelf-capacity (e.g. articles with very low volume like expensive cosmetics)									             												             -> before             There was only the possibility for the user to say "Estimation YES or NO" with ESTIMATION_FG - (which still exist in the tables).             If he decided on "YES" then the article undergoes the whole estimation calculation with rounding-logic, stock consideration etc..             There are a lot of articles which have very low sales quantities due a bad price or less attractivity -> still the user would have to check everything, maybe adjust the forecast.             To reduce effort, with the ESTIMATION_ID the user will have the opportunity to set the article on "only fill up shelf" and he does no longer need to check or adjust the amounts for this article.             											             ESTIMATION_FG is still used on Ausliefergruppe-level and Warengruppe-level.             An individual decision must be made at article-level and ESTIMATION_ID should therefore be used.             ');