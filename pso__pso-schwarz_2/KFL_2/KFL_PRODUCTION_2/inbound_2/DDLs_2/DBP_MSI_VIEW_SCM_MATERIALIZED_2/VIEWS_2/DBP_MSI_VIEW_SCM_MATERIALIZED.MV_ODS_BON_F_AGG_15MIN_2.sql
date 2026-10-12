create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ODS_BON_F_AGG_15MIN_2(
	DAT,
	ZEIT_STUNDE,
	ZEIT_15MIN,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	KASSE_NR,
	KASSE_TYP_ID,
	UMSATZ_BRUTTO,
	UMSATZ_NETTO,
	ANZ_ARTIKEL,
	ANZ_KUNDEN,
	KASSIERZEIT,
	REGISTRIERZEIT,
	ZAHLZEIT
) as
   
   
   
   

  SELECT
   v01.dat, v01.zeit_stunde, v01.zeit_15min, 
   
   
   v05.aktuell_wup_id,
   0 AS nb_id, v01.mandant_id, v01.kasse_nr, COALESCE(ktp.kasse_typ_id, v01.kasse_typ_id) AS kasse_typ_id, v01.umsatz_brutto, v01.umsatz_netto, v01.anz_artikel, v01.anz_kunden, v01.kassierzeit, v01.registrierzeit, v01.zahlzeit
   FROM dbp_v_ods.v_ods_bon_agg_15min_2 v01
   
   INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id =  v01.mandant_id
  
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   LEFT OUTER JOIN dbp_view.v_kasse_typ_per_2 ktp
   ON v01.mandant_id = ktp.mandant_id
   AND v01.wup_id = ktp.wup_id
   AND v01.kasse_nr = ktp.kasse_nr
   AND v01.dat BETWEEN ktp.dat_von AND ktp.dat_bis;