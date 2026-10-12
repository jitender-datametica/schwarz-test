CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_PLAN_TAG
(
mandant_id
,wup_id
,nb_id
,dat_plan
,dat_plan_tag_monat
,dat_plan_wochentag
,getraenkemarkt_fg
,getraenkemarkt_bez
,ref_wup_id
,ref_dat_vj
,ref_dat_vj_man
,ums_steigerung_faktor
,ums_brutto_plan
,ums_brutto_plan_hochrechnung
,ums_brutto_plan_man
,offen_fg_plan
,ref_betrag_bon_pos_brutto
,ref_betrag_bon_brutto
,anz_kunde_plan
,registrierzeit_plan
,zahlzeit_plan
,kassierzeit_plan
,kassierzeit_pep_plan
,kassierzeit_pep_ist
,kassierzeit_bon_ist
,kassierzeit_bon_std
,kassierzeit_plan_inkl_ll
,kassierzeit_bon_std_inkl_ll
,ums_brutto_ist_bondaten
,registrierzeit_bon_ist
,zahlzeit_bon_ist
,anz_artikel
,anz_kunden
,ereignistyp_id
,ereignis_id
)
AS
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.dat_plan
   --, CAST(v01.dat_plan  AS FORMAT 'DD.MM.')::VARCHAR(20) AS dat_plan_tag_monat
   ,to_varchar(v01.dat_plan, 'DD.MM')::VARCHAR(20) AS dat_plan_tag_monat
   , SUBSTRING(v03.wtag_bez, 1, 2)   dat_plan_wochentag, v01.getraenkemarkt_fg, CASE
   WHEN v01.getraenkemarkt_fg = 0
   THEN 'nur Markt'
   ELSE 'nur seperater Getränkemarkt'
   END      AS getraenkemarkt_bez, v01.ref_wup_id, v01.ref_dat_vj, v01.ref_dat_vj_man, v01.ums_steigerung_faktor, v01.ums_brutto_plan, CASE
   WHEN v01.ums_brutto_plan_man IS NOT NULL AND v01.ums_brutto_plan_man <> 0
   THEN v01.ums_brutto_plan_man
   ELSE v01.ums_brutto_plan
   END      AS ums_brutto_plan_hochrechnung, v01.ums_brutto_plan_man, v01.offen_fg_plan, v01.ref_betrag_bon_pos_brutto, v01.ref_betrag_bon_brutto, v01.anz_kunde_plan, v01.registrierzeit_plan, v01.zahlzeit_plan, v01.kassierzeit_plan, v01.kassierzeit_pep_plan, v01.kassierzeit_pep_ist, v01.kassierzeit_bon_ist, v01.kassierzeit_bon_std, v01.kassierzeit_plan_inkl_ll, v01.kassierzeit_bon_std_inkl_ll, v01.ums_brutto_ist_bondaten, v01.registrierzeit_bon_ist, v01.zahlzeit_bon_ist, v01.anz_artikel, v01.anz_kunden, v04.ereignistyp_id, v04.ereignis_id

   FROM dbp_msi_v_view.v_pep_plan_tag v01

   JOIN dbp_view.v_tag v02
   ON v01.dat_plan = v02.dat

   JOIN dbp_view.v_wtag_spr_zu v03
   ON  v02.wtag_id = v03.wtag_id
   AND 22 = v03.spr_id
   LEFT JOIN (SELECT v04_1.mandant_id, v04_1.wup_id, v04_1.nb_id, v04_1.dat, v04_1.ereignistyp_id, v04_1.ereignis_id
   FROM dbp_view.v_wupcal_ereignis_zu v04_1
   WHERE v04_1.ereignistyp_id = 100  -- nur die Standardkommentare anzeigen. Wenn auch Freitext angezeigt wird, dann eine weitere Spalte dafür generieren
   ) v04
   ON v01.mandant_id = v04.mandant_id
   AND v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id
   AND v01.dat_plan - 364 = v04.dat -- Vorjahreskommentar soll angezeigt werden
   ;