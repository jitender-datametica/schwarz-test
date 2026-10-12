CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ODS_BON_F_AGG_15MIN_1(
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
) AS
   -- FAKT/AGGREGAT Bondaten verdichtet auf Stunde/15 Min
   -- 20151221 ssch0611 : zusaetzliche Spalten registrier-/zahlzeit
   -- 2019.0507 awol2209: coalesce Kassentyp aufgenommen
   -- 20190625 snik1809 : added bonanzahl_sug, redirected to dbe_mig_ods_27.ods_bon_agg_15min_1
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
  SELECT
   v01.dat, v01.zeit_stunde, v01.zeit_15min, 
   --v01.wup_id, 
   --CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id,
   v05.aktuell_wup_id,
   0 AS nb_id, v01.mandant_id, v01.kasse_nr, COALESCE(ktp.kasse_typ_id, v01.kasse_typ_id) AS kasse_typ_id, v01.umsatz_brutto, v01.umsatz_netto, v01.anz_artikel, v01.anz_kunden, v01.kassierzeit, v01.registrierzeit, v01.zahlzeit
   FROM dbp_v_ods.v_ods_bon_agg_15min_1 v01
   
   INNER JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id =  v01.mandant_id
  -- AND v05.wup_id = CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id AS INTEGER) END
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   LEFT OUTER JOIN dbp_view.v_kasse_typ_per_1 ktp
   ON v01.mandant_id = ktp.mandant_id
   AND v01.wup_id = ktp.wup_id
   AND v01.kasse_nr = ktp.kasse_nr
   AND v01.dat BETWEEN ktp.dat_von AND ktp.dat_bis;