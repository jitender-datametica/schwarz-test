CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LIEFERANT_2
-- 26.07.2011 neue Spalten hinzugefuegt audit.. hinzugefuegt, Umbennenung lief_betreuer_name  in lief_betreuer_id
-- 26.10.2011 system_id entfernt
-- 13.12.2012 twie: statt werk_id die werk_id_flw auslesen, da werk_id durch Projekt SAKO anders verwendet
-- 10.01.2013 twie: Filterung auf mandant_id 1,2 wegen Projekt SAKO
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 07.03.2013 twie: aenderung in Datenmodell durch SAKO, lief_name aufgeteilt in lief_name_1 und lief_name_2
-- 01.04.2014 twie: audit_dat ,audit_qzahl entfernt, da jetzt historisiert in Tabelle flw_lieferant_audit_per_2
-- 13.08.2014 twie: mandant_id_werk ausgeben, die entspricht nicht der mandant_id des Lieferanten
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014

(
in_lief_id
,mandant_id
,lief_name
,in_lief_nr
,gp_ort
,lief_betreuer_id
,werk_id
,mandant_id_werk
,in_lief_grp_id
,in_lief_grp_mandant_id
)
AS
   SELECT
   dt1.flw_lief_id AS in_lief_id, dt1.mandant_id, cast(trim(dt1.lief_name_1) || ' ' ||  trim(dt1.lief_name_2)as varchar(161)) as lief_name -- beide Felder haben varchar(80)
   , COLLATE(LTRIM(COLLATE(dt1.flw_lief_nr,''),'0'), 'en-ci') AS in_lief_nr, gp_ort, lief_betreuer_id, werk_id_flw as werk_id, mandant_id_werk, CASE WHEN dt1.mandant_id=2 and dt1.flw_lief_id_cz > 0 then flw_lief_id_cz 
   else dt1.flw_lief_id
   END AS in_lief_grp_id, CASE WHEN dt1.mandant_id=2 and dt1.flw_lief_id_cz > 0 then 1
   ELSE dt1.mandant_id
   END as in_lief_grp_mandant_id

   FROM dbp_view.v_flw_lieferant_2 dt1
   INNER JOIN dbp_view.v_flw_lieferant_ekorg_zu_2 dt2
   ON dt1.mandant_id = dt2.mandant_id
   AND dt1.flw_lief_id = dt2.flw_lief_id

   WHERE dt2.einkaufsorganisation_id IN (5000,5013,5014)
   AND dt1.mandant_id in (1,2);