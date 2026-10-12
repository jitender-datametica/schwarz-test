CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ART_UMBEWERTUNG_1 
   (
	MANDANT_ID,
	UMBEW_BELEG_ID,
	UMBEW_BELEG_POS_ID,
	KJ,
	PREIS_AEND_GRUND_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_UMBEW,
	MENGE_UMBEW,
	WRG_ID,
	MENGE_BERECHNET,
	GP_ID,
	UMRECHNUNGSKURS_0,
   UMRECHNUNGSKURS_1,
	DIFF_WERT_BESTAND_BRUTTO,
	VK_BRUTTO_ALT,
	DIFF_WERT_BESTAND_NETTO
   ) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
   AS 
      SELECT
   v01.mandant_id,
   v01.umbew_beleg_id,
   v01.umbew_beleg_pos_id,
   v01.kj,
   v01.preis_aend_grund_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.dat_umbew,
   menge_umbew,
   wrg_id,
   CASE
   --Storno Vertrieb + VK_1 Korrektur per Programm --
   WHEN v01.mandant_id IN (3, 6, 7, 8) AND v01.preis_aend_grund_id IS NULL
   THEN NULL
   --Einkauf --
   WHEN v01.mandant_id = 6 AND v01.preis_aend_grund_id = 50 THEN 0
   WHEN v01.mandant_id  IN (2, 3, 4, 5, 7, 8) AND v01.preis_aend_grund_id = 12 THEN menge_umbew
   WHEN v01.mandant_id  IN (2, 4, 5, 7, 8) AND v01.preis_aend_grund_id = 11 THEN menge_umbew
   WHEN v01.preis_aend_grund_id IN (9, 10) THEN menge_umbew
   --Vertrieb --
   WHEN v01.mandant_id IN (2, 4, 5, 7, 8) AND v01.preis_aend_grund_id = 7
   AND wert_bestand_brutto_alt < 0
   AND menge_bestand_bme < 0
   AND menge_umbew = 0
   THEN menge_erf * (-1)
   WHEN v01.mandant_id = 6 AND v01.preis_aend_grund_id = 2
   AND wert_bestand_brutto_alt < 0
   AND menge_bestand_bme < 0
   AND menge_umbew = 0
   THEN menge_erf * (-1)
   WHEN v01.mandant_id IN(3, 4) AND v01.preis_aend_grund_id = 11
   AND wert_bestand_brutto_alt < 0
   AND menge_bestand_bme < 0
   AND menge_umbew = 0
   THEN menge_erf * (-1)
   --Bonuskauf --
   WHEN v01.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND v01.preis_aend_grund_id = 6
   AND wert_bestand_brutto_alt < 0
   AND menge_bestand_bme < 0
   AND menge_umbew = 0
   THEN menge_erf * (-1)
   ELSE menge_erf
   END AS menge_berechnet,
   v02.gp_id,
v300.umrechnungskurs AS umrechnungskurs_0,
v400.umrechnungskurs AS umrechnungskurs_1,
v01.diff_wert_bestand_brutto,
v01.vk_brutto_alt,
v01.diff_wert_bestand_netto
  FROM dbp_view.v_art_umbewertung_1 v01
   LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 v02
   ON v01.art_id = v02.art_id
   AND v01.wup_id =v02.wup_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.dat_umbew BETWEEN v02.dat_von AND v02.dat_bis

 /* INNER JOIN dbp_view.v_kurs_1 v300
   ON v01.dat_umbew BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v400
   ON v01.dat_umbew BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.mandant_id <> 1;