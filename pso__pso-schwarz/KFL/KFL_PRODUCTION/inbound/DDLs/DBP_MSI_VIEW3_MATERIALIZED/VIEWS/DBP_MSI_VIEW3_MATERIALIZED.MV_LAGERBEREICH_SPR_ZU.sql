create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERBEREICH_SPR_ZU(
	LAGERBEREICH_BEZ,
	LAGERBEREICH_ID,
	LAGERNUMMER_ID,
	LAGERTYP_ID,
	MANDANT_ID,
	NB_ID,
	SPR_ID,
	WUP_ID
) as 
--2019.08.15 [nwag2310] if no record in user language is available, display the text maintained in default language
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   lagerbereich_bez,
   lagerbereich_id,
   lagernummer_id,
   lagertyp_id,
   mandant_id,
   nb_id,
   spr_id,
   wup_id
FROM
   (
      SELECT
         v01.lagerbereich_bez,
         v01.lagerbereich_id,
         v01.lagernummer_id,
         v01.lagertyp_id,
         v01.mandant_id,
         v01.nb_id,
         v01.spr_id,
         v01.wup_id,
         CASE WHEN v02.spr_id IS NOT NULL THEN 1
            WHEN v03.spr_id = v01.spr_id THEN 2
            ELSE 3
         END AS prio,
         ROW_NUMBER() OVER (
            PARTITION BY v01.lagerbereich_id,
            v01.lagernummer_id,
            v01.lagertyp_id,
            v01.mandant_id,
            v01.nb_id,
            v01.wup_id
            ORDER BY
               prio ASC
         ) AS rownum
      FROM
         dbp_view.v_lagerbereich_spr_zu v01
         JOIN dbp_view.v_mandant_spr_zu v03 
         ON v01.mandant_id = v03.mandant_id
         LEFT OUTER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
         ON v01.spr_id = v02.spr_id
   ) t
WHERE
   rownum = 1;