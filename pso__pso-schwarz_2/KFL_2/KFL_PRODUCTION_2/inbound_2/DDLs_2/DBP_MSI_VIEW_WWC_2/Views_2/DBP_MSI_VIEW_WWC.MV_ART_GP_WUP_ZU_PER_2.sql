CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_GP_WUP_ZU_PER_2
(
mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,einkaufsorganisation_id
,dat_von
,dat_bis
,dat_zeitraum
,dat
,ek_nettonetto
,ek_netto
,ek_brutto
,ek_mep
,einstandspreis
,logistikkostenzuschlag
,ek_netto_bnk
,bonusbasis
,ek_mep_vor_fwu
,bezugsnebenkosten
,ek_netto_bnk_sachk
,wrg_id
,letzter_tag_monat_flag
)
AS
-- 20.02.2014 twie: ek_mep und einstandpreis ausgeben
-- richternic 20210507 SPEC0111757: Add logistikkostenzuschlag &  EK_NETTO_BNK & WRG_ID & KJMO & FLag fuer letzter Tag_2 im Monat_2 
-- 14.12.2022, SPEC0174299. prescherad: Neue Metriken - FWU
-- 15.01.2024 ,SPEC0231938, prescherad: Optimierung der View. Zeitraum bis wird eingeschänt auf 2 Jahre in die Zukunft und die Abhängigkeit zur MV_View aufgelöst
-- 13.11.2024, NSR4928552, prescherad: Anpassung Join Verfahren zur Vermeidung von NULL Werten   
   SELECT
   v01.mandant_id,
   v01.art_id,
   v01.gp_id,
   v01.wup_id,
   0,
   v01.einkaufsorganisation_id,
   v01.dat_von,
   v01.dat_bis,
   CAST (v01.dat_von AS VARCHAR) || ' - ' || CAST(v01.dat_bis AS VARCHAR),
   dat,
   ek_nettonetto,
   ek_netto,
   ek_brutto,
   ek_mep,
   einstandspreis,
   logistikkostenzuschlag,
   ek_netto_bnk,
   bonusbasis,
   ek_mep_vor_fwu,
   bezugsnebenkosten,
   ek_netto_bnk_sachk,
   wrg_id,
   --um den EK des letzten Tages im Monat_2 zu markieren.
   CASE WHEN LAST_DAY(v02.dat, "MONTH") = v02.dat THEN 1 ELSE 0 END AS letzter_Tag_Monat_flag
   FROM
   dbp_view.v_art_gp_wup_zu_per_2 v01
   JOIN (
   SELECT
   dat,
   kjmo,
   kjwo,
   kj,
   akt_kj
   FROM dbp_view.v_tag_2 v01
   --prescherad: Einschränkung auf 2 Jahre in die Zukunft
   WHERE akt_kj BETWEEN -3 AND 2

   UNION ALL
   
  (SELECT
   CAST( '9999-12-31' AS VARCHAR ) AS dat,
   CAST( 999912 AS INTEGER) AS kjmo,
   CAST( 999952 AS INTEGER) AS kjwo,
   CAST( 9999 AS SMALLINT) AS kj,
   CAST( 9999 AS SMALLINT) AS akt_kj)
   )v02
   
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis 
   --and v02.dat <= date
   --where mandant_id <> 1
;