CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_WEWA_ROW_2
(
	MANDANT_ID,
	RECH_BELEG_ID,
	RECH_BELEG_KONT_POS_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	DAT_BUCH,
	ART_ID,
	WEWA_JAHR,
	UMRECHNUNGSKURS_0,
   UMRECHNUNGSKURS_1,
	MANDANT_ID_BR,
	KURSF_BR,
	BETRAG_BELEG_BRK,
	POSTEN_KZ_PER
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO

   AS
    SELECT

   brk.mandant_id,
   brk.rech_beleg_id,
   brk.rech_beleg_kont_pos_id,
   COALESCE(br.wup_id, 0) AS wup_id,
   COALESCE(br.nb_id,-1) AS nb_id,
   br.gp_id,
   br.dat_buch,
   CAST(-2 AS INTEGER) art_id,
   br.gj AS wewa_jahr,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   v300.umrechnungskurs AS umrechnungskurs_0,
   v400.umrechnungskurs AS umrechnungskurs_1,
br.mandant_id AS mandant_id_br,
br.kursf AS kursf_br,
brk.betrag_beleg AS betrag_beleg_brk,
CASE WHEN v04.POSTEN_ID NOT IN ('1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per

   FROM dbp_view.v_besch_rech_det_kont_2 brk
   INNER JOIN dbp_view.v_besch_rech_2  br
   ON    brk.mandant_id =  br.mandant_id
   AND brk.rech_beleg_id= br.rech_beleg_id
   AND brk.gj = br.gj
   INNER JOIN dbp_view.v_mandant_2  m
   ON brk.mandant_id= m.mandant_id

   /* JOIN dbp_view.v_kurs_2 v300
   ON br.dat_buch BETWEEN v300.dat_von
   AND v300.dat_bis
   AND m.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND m.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_2 v400
   ON br.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
   AND m.default_wrg = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'


   LEFT JOIN dbp_view.v_art_per_2 v04
   ON -2 = v04.art_id
   AND brk.mandant_id = v04.mandant_id
   AND br.dat_buch BETWEEN v04.dat_von-1 AND v04.dat_bis-1 

   WHERE
   -- Entsprechend dem IT konzept definierte und für RoW zu berücksichtigende Sachkonto
   (brk.mandant_id IN (2,3,5, 6) AND sachkonto_id IN ('R097761', 'R097762', 'R097763') )
   OR (brk.mandant_id IN (7,8) AND sachkonto_id IN ('0000097761', '0000097762', '0000097763') );