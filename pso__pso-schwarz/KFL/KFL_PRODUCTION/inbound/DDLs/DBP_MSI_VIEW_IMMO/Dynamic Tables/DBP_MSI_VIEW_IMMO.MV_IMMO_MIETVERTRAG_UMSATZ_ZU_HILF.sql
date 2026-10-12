CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_UMSATZ_ZU_HILF(
	MANDANT_ID,
	MV_INTRENO,
	WE_INTRENO,
	MO_INTRENO,
	KJMO,
	WRG_ID,
	WRG_TYP_ID,
	COUNT_KJMO
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT DISTINCT
   v18.mandant_id, v18.mv_intreno, v18.we_intreno, v18.mo_intreno, v18.kjmo, v18.wrg_id, v18.wrg_typ_id, COUNT (v18.mietvertrag_nr) AS count_kjmo

   FROM

   (--active contracts in national currency
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id, v1.mietvertrag_nr, v9.we_intreno_akt AS we_intreno, v9.mv_intreno_akt AS mv_intreno, v9.mo_intreno_akt AS mo_intreno, v2.kjmo, v2.rhythmus_art, v2.VERSION, v2.wrg_id, v6.wrg_typ_id, v8.kj, v8.akt_kj, v8.akt_mo

   FROM dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   INNER JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   INNER  JOIN dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
   INNER  JOIN dbp_msi_view_immo.mv_l_kj_monat v8
   ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id
   WHERE v2.VERSION = (SELECT MAX(v11.VERSION) FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11 WHERE v2.mv_intreno=v11.mv_intreno AND v2.kjmo=v11.kjmo AND v2.melderegel=v11.melderegel)
   AND v2.nullumsatz <> 'X' AND v2.umsatz_netto > 0
   AND v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id AND v2.rhythmus_art='0001'

   UNION ALL
   --old contracts in national currency
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id, v1.mietvertrag_nr, v9.we_intreno_akt AS we_intreno, v9.mv_intreno_akt AS mv_intreno, v9.mo_intreno_akt AS mo_intreno, v2.kjmo, v2.rhythmus_art, v2.VERSION, v2.wrg_id, v6.wrg_typ_id, v8.kj, v8.akt_kj, v8.akt_mo

   FROM dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   INNER JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   INNER  JOIN dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
   INNER  JOIN dbp_msi_view_immo.mv_l_kj_monat v8
   ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id
   WHERE v2.VERSION = (SELECT MAX(v11.VERSION) FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11 WHERE v2.mv_intreno=v11.mv_intreno AND v2.kjmo=v11.kjmo AND v2.melderegel=v11.melderegel)
   AND v2.nullumsatz <> 'X' AND v2.umsatz_netto > 0
   --AND v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id AND v2.rhythmus_art='0001'


   UNION ALL

   --active contracts in EUR
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id, v1.mietvertrag_nr, v9.we_intreno_akt AS we_intreno, v9.mv_intreno_akt AS mv_intreno, v9.mo_intreno_akt AS mo_intreno, v2.kjmo, v2.rhythmus_art, v2.VERSION, 'EUR' AS wrg_id, 0 AS wrg_typ_id, v8.kj, v8.akt_kj, v8.akt_mo

   FROM dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   INNER JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   INNER  JOIN dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
   INNER  JOIN dbp_msi_view_immo.mv_l_kj_monat v8
   ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id
   WHERE v2.VERSION = (SELECT MAX(v11.VERSION) FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11 WHERE v2.mv_intreno=v11.mv_intreno AND v2.kjmo=v11.kjmo AND v2.melderegel=v11.melderegel)
   AND v2.nullumsatz <> 'X' AND v2.umsatz_netto > 0
   AND v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id AND v2.rhythmus_art='0001'


   UNION ALL

   --old contracts in EUR
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id, v1.mietvertrag_nr, v9.we_intreno_akt AS we_intreno, v9.mv_intreno_akt AS mv_intreno, v9.mo_intreno_akt AS mo_intreno, v2.kjmo, v2.rhythmus_art, v2.VERSION, 'EUR' AS wrg_id, 0 AS wrg_typ_id, v8.kj, v8.akt_kj, v8.akt_mo

   FROM dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   INNER JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   INNER  JOIN dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id AND v6.wrg_typ_id = 1
   INNER  JOIN dbp_msi_view_immo.mv_l_kj_monat v8
   ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id
   WHERE v2.VERSION = (SELECT MAX(v11.VERSION) FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v11 WHERE v2.mv_intreno=v11.mv_intreno AND v2.kjmo=v11.kjmo AND v2.melderegel=v11.melderegel)
   AND v2.nullumsatz <> 'X' AND v2.umsatz_netto > 0
   --AND v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id AND v2.rhythmus_art='0001'

   /*UNION ALL

   --active empty contracts
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id
   ,v1.mietvertrag_nr
   ,v9.we_intreno_akt AS we_intreno
   ,v9.mv_intreno_akt AS mv_intreno
   ,v9.mo_intreno_akt AS mo_intreno
   --,v1.partner_id
   --,v1.partner_id AS konzessionaer_id
   --,v1.vertragsart_id
   ,v2.kjmo
   --,v2.melderegel
   ,v2.rhythmus_art
   --,v2.umsatz_brutto
   --,v2.umsatz_netto
   --,v2.umsatzkennung
   ,v2.VERSION
   ,v2.wrg_id
   ,v6.wrg_typ_id
   --,v5.objektleiter_id
   , v8.kj
   ,v8.akt_kj
   ,v8.akt_mo


   FROM dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   left JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   left  JOIN  dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id --AND v6.wrg_typ_id = 1
   left  JOIN  dbp_msi_view_immo.mv_l_kj_monat v8
   ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id

   WHERE v2.mv_intreno is null
   AND v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id AND v2.rhythmus_art='0001'

   UNION ALL

   --old empty contracts
   SELECT DISTINCT
   --v1.branche_id
   v1.mandant_id
   ,v1.mietvertrag_nr
   ,v9.we_intreno_akt AS we_intreno
   ,v9.mv_intreno_akt AS mv_intreno
   ,v9.mo_intreno_akt AS mo_intreno
   --,v1.partner_id
   --,v1.partner_id AS konzessionaer_id
   --,v1.vertragsart_id
   ,v2.kjmo
   --,v2.melderegel
   ,v2.rhythmus_art
   --,v2.umsatz_brutto
   --,v2.umsatz_netto
   --,v2.umsatzkennung
   ,v2.VERSION
   ,v2.wrg_id
   ,v6.wrg_typ_id
   --,v5.objektleiter_id
   , v8.kj
   ,v8.akt_kj
   ,v8.akt_mo


   FROM dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v1
   left JOIN dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v2
   ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
   left  JOIN  dbp_msi_view_immo.mv_mandant_wrg_typ_zu v6
   ON  v1.mandant_id = v6.mandant_id AND v2.wrg_id = v6.wrg_id --AND v6.wrg_typ_id = 1
   left  JOIN  dbp_msi_view_immo.mv_l_kj_monat v8
   ON v2.kjmo = v8.kjmo
   JOIN dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf AS v9
   ON v1.mietvertrag_nr = v9.mietvertrag_nr  AND v1.mandant_id = v9.mandant_id

   WHERE v2.mv_intreno is null
   --AND v2.mv_intreno = v9.mv_intreno_akt AND v9.mandant_id = v2.mandant_id AND v2.rhythmus_art='0001'*/
   ) AS v18
   WHERE v18.rhythmus_art='0001'
   GROUP BY
   v18.mandant_id
   ,v18.mv_intreno
   ,v18.we_intreno
   ,v18.mo_intreno
   ,v18.kjmo
   ,v18.wrg_id
   ,v18.wrg_typ_id;