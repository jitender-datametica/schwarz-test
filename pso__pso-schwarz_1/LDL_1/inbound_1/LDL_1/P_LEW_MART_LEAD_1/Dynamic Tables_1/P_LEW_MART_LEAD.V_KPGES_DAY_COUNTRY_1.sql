CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_KPGES_DAY_COUNTRY_1
(
  client_id
, indicator_id
, dat_formdate
, val_indicator
, currency_iso_cd
, dat_dayend
, curr_tot_id
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
     iday.client_id,
   iday.indicator_id,
   iday.dat_formdate,
   CASE
      WHEN iday.indicator_id IN
            (117 ,120 ,125 ,126 ,133 ,135 ,136 ,155 ,156 ,157 ,163 ,168
            ,169 ,170 ,172 ,174 ,177 ,179 ,203 ,204 ,209 ,210 ,212 ,216
            ,228 ,229 ,230 ,238 ,240 ,242 ,250 ,251 ,255 ,256 ,257 ,258
            ,259 ,260 ,261 ,270 ,271 ,272 ,273 ,280 ,281 ,282 ,283 ,284
            ,286
            )
        THEN  iday.val_indicator / CASE WHEN cry.rate_currency_exchange = 0 THEN NULL ELSE cry.rate_currency_exchange END
   ELSE iday.val_indicator
 END AS val_indicator,
   cry.currency_iso_cd,
   iday.dat_dayend,
   CAST(CASE
           WHEN cry.currency_iso_cd = 'EUR'
             THEN 0
           WHEN cry.currency_iso_cd = 'GBP'
             THEN 40
           ELSE iday.client_id
         END AS SMALLINT) AS curr_tot_id
  FROM p_lew_bil_ac.v_kpi_day_1 AS iday
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
   ON iday.client_id = cry.client_id
   AND iday.indicator_type_id = 1
   AND iday.org_type_id = 20
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
