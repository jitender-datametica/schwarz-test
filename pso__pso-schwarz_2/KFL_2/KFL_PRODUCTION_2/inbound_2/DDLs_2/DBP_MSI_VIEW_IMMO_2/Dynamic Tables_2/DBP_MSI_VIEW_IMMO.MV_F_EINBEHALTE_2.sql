CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_F_EINBEHALTE_2(
	MANDANT_ID,
	BUCHUNGSKREIS_ID,
	IN_FI_BELEG_ID,
	DAT_BUCH,
	WE_INTRENO,
	EINBEHALT_TYP,
	IND_VZ,
	BETRAG_FI_BELEG,
	WRG_ID,
	WRG_TYP_ID,
	IN_LIEF_ID,
	EXT_REF_BELEG_NR,
	IN_FI_BELEG_POS_BEZ,
	BEST_BELEG_ID,
	DAT_NETTOFAELLIGKEIT,
	DAT_AENDERUNG,
	EINKAEUFER_GRP_ID,
	PSP_ID
) TARGET_LAG= '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
SELECT fi.mandant_id,
   CAST(fi.buchungskreis_id AS VARCHAR(20)) AS buchungskreis_id,
   fi.in_fi_beleg_id,
   fi.dat_buch,
   we.we_intreno,
   CASE
      WHEN fi.sonder_hauptbuch_kz = 1 THEN 'Abnahmeeinbehalte'
      WHEN fi.sonder_hauptbuch_kz = 2 THEN 'Sicherheitseinbehalte'
      WHEN fi.sonder_hauptbuch_kz = 3 THEN 'Gewährleistungseinbehalte'
      WHEN fi.sonder_hauptbuch_kz = 4 THEN 'Vertragsstrafeneinbehalt'
      WHEN fi.sonder_hauptbuch_kz = 5 THEN 'Rechnungseinbehalt'
   END AS einbehalt_typ,
   CASE
      WHEN soll_haben_kz = 'S' THEN + 1
      ELSE -1
   END ind_vz,
   CASE
      WHEN wt.wrg_typ_id = 1 THEN betrag_fi_beleg * ind_vz
      ELSE betrag_fi_beleg * ind_vz * ku.umrechnungskurs
   END AS betrag_fi_beleg,
   wt.wrg_id,
   wt.wrg_typ_id,
   fk.in_lief_id,
   fk.ext_ref_beleg_nr,
   fi.in_fi_beleg_pos_bez,
   bf.best_beleg_id,
   fd.dat_basis + zz.zahlungsziel_max_tage AS dat_nettofaelligkeit,
   fi.dat_aenderung,
   b.einkaeufer_grp_id,
   psp_id
FROM dbp_view.v_in_fi_beleg_det_2 fi
   JOIN dbp_view.v_in_fi_beleg_kred_2 fk ON fi.mandant_id = fk.mandant_id
   AND fi.in_fi_beleg_id = fk.in_fi_beleg_id
   AND fi.buchungskreis_id = fk.buchungskreis_id
   AND fi.in_fi_beleg_pos_id = fk.in_fi_beleg_pos_id
   AND fi.gj = fk.gj
   LEFT JOIN dbp_view.v_in_fi_beleg_dat_2 fd ON fi.mandant_id = fd.mandant_id
   AND fi.in_fi_beleg_id = fd.in_fi_beleg_id
   AND fi.buchungskreis_id = fd.buchungskreis_id
   AND fi.in_fi_beleg_pos_id = fd.in_fi_beleg_pos_id
   AND fi.gj = fd.gj
   JOIN (
      SELECT bf.mandant_id,
         bf.best_beleg_id,
         bf.folge_beleg_id,
         bf.kj,
         bk.psp_id,
         Max(bk.geschaeftsbereich_id) geschaeftsbereich_id
      FROM dbp_view.v_in_best_belegfluss_2 bf
         JOIN dbp_view.v_in_besch_best_kontierung_2 bk 
         ON bf.mandant_id = bk.mandant_id
         AND bf.best_beleg_id = bk.best_beleg_id
         JOIN dbp_view.v_in_besch_best_det_2 bd ON bk.mandant_id = bd.mandant_id
         AND bk.best_beleg_id = bd.best_beleg_id
         AND bk.best_beleg_pos_id = bd.best_beleg_pos_id
      WHERE bd.loesch_id <> 'L'
      GROUP BY 1,
         2,
         3,
         4,
         5
   ) bf ON fi.mandant_id = bf.mandant_id
   AND fi.gj = bf.kj
   AND Cast(
      TRUNC(fi.referenzschluessel_id / 10000) AS DECIMAL(18, 0)
   ) = bf.folge_beleg_id
   LEFT JOIN dbp_view.v_in_besch_best_2 b ON fi.mandant_id = b.mandant_id
   AND bf.best_beleg_id = b.best_beleg_id
   LEFT JOIN dbp_view.v_in_lieferant_ekorg_zu_2 lo ON fk.mandant_id = lo.mandant_id
   AND fk.in_lief_id = lo.in_lief_id
   AND b.einkaufsorganisation_id = lo.einkaufsorganisation_id
   LEFT JOIN dbp_view.v_in_l_zahlungsziel_2 zz ON fi.mandant_id = zz.mandant_id
   AND lo.zahlungsziel_id = zz.zahlungsziel_id 
   JOIN dbp_view.v_mandant_wrg_typ_zu_2 wt ON fi.mandant_id = wt.mandant_id
   LEFT JOIN dbp_view.v_kurs_2 ku ON fi.wrg_id = ku.von_wrg_id
   AND fi.dat_buch BETWEEN ku.dat_von AND ku.dat_bis
   AND ku.kurstyp_id = 9
   AND ku.nach_wrg_id = 'EUR'
   LEFT JOIN dbp_view.v_immo_wirtschaftseinheit_2 we ON Trim(bf.geschaeftsbereich_id) = we.wirtschaftseinheit_id
   AND bf.mandant_id = we.mandant_id
   AND fi.buchungskreis_id = we.buchungskreis_id
WHERE fi.sonder_hauptbuch_kz IN ('1', '2', '3', '4', '5')
   AND fi.buchungskreis_id NOT IN (154, 222, 588, 624, 625, 629, 800, 801)
   AND fk.offen_posten_fg = 1;