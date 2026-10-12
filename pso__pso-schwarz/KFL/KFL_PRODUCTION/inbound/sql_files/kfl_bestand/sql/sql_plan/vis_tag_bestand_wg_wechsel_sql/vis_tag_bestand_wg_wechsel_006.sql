--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1' does not exist or not authorized.
UPDATE t1

SET abt_id = tmp.abt_id
FROM DBP_MSI_DATA.vis_tag_bestand_wg t1,
(SELECT mandant_id
       ,wg_id
       ,abt_id
       ,arthiertyp_id
 FROM DBP_DATA.wg_per
 WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD')
   AND arthiertyp_id = 2
) tmp WHERE t1.mandant_id    = tmp.mandant_id
  AND t1.wg_id         = tmp.wg_id
  AND t1.arthiertyp_id = tmp.arthiertyp_id
  AND t1.abt_id       <> tmp.abt_id
;

