CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_PROJEKT_INV_STATUS_ZU_2
(
	MANDANT_ID,
	IN_PROJEKT_ID,
	STATUS_ID,
	STATUS_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 20.06.2013 AL init, nach dem Bestätigen von Logik durch FB ==> verlagern in BE
-- 13.07.2016 twie SPEC0012030 Filter auf ims_projekt_typ_id

   SELECT  t00.mandant_id,
   t00.in_projekt_id,
   COALESCE(status_id, 0) AS status_id,
   COALESCE(status_bez , '') status_bez
  FROM  dbp_view.v_in_projekt_2 t00
   LEFT JOIN

   (
   SELECT mandant_id,
   in_projekt_id,
   status_id,
   status_bez

  FROM
  (-- GuB
  SELECT v01.mandant_id,
   v02. in_projekt_id,
   in_projekt_id_char,
   2 AS status_id,
   'GuB' AS status_bez,
   MIN(v01.dat_buch) dat
  FROM  dbp_view.v_ist_kosten_det_2 v01

   JOIN  dbp_view.v_in_psp_element_2 v02
   ON
   v01.psp_id  = v02.psp_id AND
   v01.mandant_id=v02.mandant_id

   JOIN  dbp_view.v_anlage_klasse_zu_per_2 v03
   ON v01.anlage_id              =  v03.anlage_id
   AND  v01.anlage_sub_id      =  v03.anlage_sub_id
   AND  v01.mandant_id           =  v03.mandant_id
   AND  v01.buchungskreis_id   = v03. buchungskreis_id
   AND  v03.dat_bis= '9999-12-31'
   AND v03.anlage_klasse_id    = '11000000'

   JOIN  dbp_view.v_in_projekt_2 v04
   ON
   v02.in_projekt_id = v04.in_projekt_id AND
   v02.mandant_id  =  v04.mandant_id

   WHERE v04.ims_projekt_typ_id = 'E' OR v04.ims_projekt_typ_id = 'B'
   GROUP BY  v01.mandant_id, v02.in_projekt_id, in_projekt_id_char

   UNION

   --in Bau
   SELECT v01.mandant_id,
   v02. in_projekt_id,
   in_projekt_id_char,
   3 AS status_id,
   'Bau' AS status_bez,
   MIN(v01.dat_von) dat
  FROM  dbp_view.v_rpm_element_per_2  v01

   JOIN  dbp_view.v_in_projekt_2 v02
   ON
   v01.projekt_id = v02.projekt_ext_id


   JOIN  dbp_view.v_rpm_phase_spr_zu_2 v03
   ON v01.rpm_phase_id = v03.rpm_phase_id AND
   v01.rpm_projekt_typ_id = v03.rpm_projekt_typ_id AND
   spr_id=22 AND
   rpm_phase_bez   = 'Im Bau'
   WHERE  v02.ims_projekt_typ_id = 'E' OR v02.ims_projekt_typ_id = 'B'
   GROUP BY   v01.mandant_id,v02. in_projekt_id , in_projekt_id_char

   UNION

   SELECT mandant_id,
   in_projekt_id,
   in_projekt_id_char,
   4 AS status_id,
   'EÖ' AS status_bez,
   dat_massnahme_ende AS dat

  FROM  dbp_view.v_in_projekt_2 v01
   WHERE  (v01.ims_projekt_typ_id = 'E' OR v01.ims_projekt_typ_id = 'B') AND dat_massnahme_ende < CURRENT_DATE


   UNION

   --Status_2 Abr.
   SELECT v01.mandant_id,
   v01. in_projekt_id,
   in_projekt_id_char,
   5 AS status_id,
   'Abr.' AS status_bez,
   MAX(dat_abschluss) AS dat

  FROM  dbp_view.v_in_projekt_2 v01
   JOIN  dbp_view.v_in_psp_element_2 v02
   ON
   v01.in_projekt_id = v02.in_projekt_id AND
   v01.mandant_id  =  v02.mandant_id

   WHERE  (v01.ims_projekt_typ_id = 'E' OR v01.ims_projekt_typ_id = 'B') AND
   (v01.mandant_id,  v01.in_projekt_id) NOT IN (SELECT mandant_id,
   in_projekt_id
  FROM  dbp_view.v_in_psp_element_2
  WHERE dat_abschluss IS NULL)
  GROUP BY     v01.mandant_id, v01. in_projekt_id ,v01. in_projekt_id_char
  )              t

  QUALIFY status_id = MAX(status_id) OVER (PARTITION BY mandant_id,  in_projekt_id)
  ) t01
   ON t00.in_projekt_id = t01.in_projekt_id AND
   t00.mandant_id  = t01.mandant_id

   WHERE (t00.mandant_id,  t00.in_projekt_id) IN (SELECT mandant_id,
   in_projekt_id
  FROM  dbp_view.v_in_psp_element_2
  WHERE statistisch_fg = 1)
  ;