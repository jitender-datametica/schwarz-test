create or replace view MATERIALISIERUNG.MV_IMMO_WSA_KPI_2(
	MANDANT_ID,
	REGION_ID,
	WE_INTRENO,
	MV_INTRENO,
	BRANCHE_ID,
	WRG_ID,
	WRG_TYP_ID,
	GROESSE,
	UMSATZ_PRODUKTIVITAET,
	KUNDE_UMSATZ
) as

   WITH momess as (
   SELECT
   --  dbe_data_fed_immo.immo_mietobjekt_2 enthält branche_id
   -- dbe_data_fed_immo.immo_mietobjekt_messung_2 enthält grösse
   -- dbe_data_fed_immo.immo_wirtschaftseinheit_2 enthält mandant_id und region_id
   we.mandant_id, we.region_id, we.we_intreno, mv.mv_intreno, CASE WHEN mv.branche_id <> 0 THEN mv.branche_id ELSE mo.branche_id END AS branche_id, SUM(mm.groesse) AS groesse
   FROM dbp_view.v_immo_wirtschaftseinheit_2 we
   JOIN dbp_view.v_immo_mietobjekt_2 mo
   ON we.mandant_id = mo.mandant_id AND we.we_intreno = mo.we_intreno
   JOIN dbp_view.v_immo_mietobjekt_messung_2 mm_2
   ON mo.mandant_id = mm.mandant_id AND mo.mo_intreno = mm.mo_intreno
   JOIN dbp_msi_view_immo.mv_we_mo_mv_zu_2 wmm
   ON we.mandant_id = wmm.mandant_id AND we.we_intreno = wmm.we_intreno AND mo.mo_intreno = wmm.mo_intreno
   JOIN dbp_view.v_immo_mietvertrag_per_2 mv
   ON we.mandant_id = mv.mandant_id AND wmm.mv_intreno = mv.mv_intreno
   -- Übernahme der Where-Clauses aus bisher genutzten Views
   WHERE
   ""CURRENT_DATE"" BETWEEN we.dat_we_gueltig_von AND we.dat_we_gueltig_bis
   AND ""CURRENT_DATE"" BETWEEN mm.dat_von AND mm.dat_bis
   AND mm.bemessung_art_id IN ('0300','0310','0320','0380')
   --AND trim(mv.mv_intreno) <> ''
   GROUP BY 1,2,3,4,5 )

   SELECT
    wsa.mandant_id, COALESCE(CASE WHEN wsa.mandant_id = 1 THEN LPAD(trim(wsa.region_id), 2, '0') ELSE momess.region_id END,'n.v.') as region_id, momess.we_intreno, momess.mv_intreno, momess.branche_id, mwt.wrg_id, mwt.wrg_typ_id, momess.groesse, CASE WHEN wrg_typ_id = 0 THEN wsa.umsatz_produktivitaet * lw.umrechnungskurs ELSE wsa.umsatz_produktivitaet END AS umsatz_produktivitaet, CASE WHEN wrg_typ_id = 0 THEN wsa.kunde_umsatz * lw.umrechnungskurs ELSE wsa.kunde_umsatz END AS kunde_umsatz

   FROM dbp_view.v_immo_wsa_kpi_2 wsa
   JOIN dbp_view.v_mandant_wrg_typ_zu_2  mwt
   ON mwt.mandant_id = wsa.mandant_id

   JOIN dbp_view.v_mandant_2 m
   ON m.mandant_id = wsa.mandant_id

   JOIN dbp_view.v_kurs_2 lw
   ON lw.von_wrg_id = m.default_wrg
   AND lw.nach_wrg_id = 'EUR'
   AND  lw.kurstyp_id = 3
   AND lw.dat_bis = '9999-12-31'

   JOIN dbp_msi_view_immo.mv_l_groesse_kategorie_2 gkat -- im FE generierte LU

   ON wsa.groesse_kategorie = gkat.groesse_kategorie

   -- with clause
   JOIN
   momess momess --with clause

   ON wsa.mandant_id = momess.mandant_id
   AND CASE WHEN wsa.mandant_id = 1 THEN LPAD(trim(wsa.region_id), 2, '0') ELSE 'Dummy_2' END = CASE WHEN wsa.mandant_id = 1 THEN momess.region_id ELSE 'Dummy_2' END
   AND wsa.branche_id = momess.branche_id
   AND momess.groesse >= gkat.groesse_von
   AND momess.groesse <= gkat.groesse_bis;