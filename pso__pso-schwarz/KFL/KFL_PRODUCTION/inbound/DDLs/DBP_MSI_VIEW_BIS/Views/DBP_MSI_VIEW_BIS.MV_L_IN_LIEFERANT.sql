CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_LIEFERANT
--03.12.2012 SHoger Initial
--10.12.2012 Alipkin
--03.04.2013 twieder: lief_name aufgeteilt
--13.06.2013 AL Dummy für INT Lieferant
--04.12.2014 SROM: einkauefer_grp_id rausgenommen, Zuordnung geht über eine neue View (Stichwort: nationaler/internationaler Einkäufer)
--                 sonstige Logik bleibt wegen sako_fg erhalten
-- 07.12.2016 twie: SPEC0017788 Lieferanten ohne EKGR (entspr. EKG -1) sind nicht beschaffungsrelevant

(
in_lief_id
,mandant_id
,lief_name_1
,lief_name_2
,in_lief_nr
,gp_ort
,werk_id
,loesch_fg
,in_lief_id_int
,subkategorie_1_id
,konzern_id
,lief_name_lang
,zuordnen_fg
,zuordnung_loeschen_fg
)

AS
SELECT dt1.in_lief_id
,dt1.mandant_id
,dt1.lief_name_1
,dt1.lief_name_2
,LTRIM(to_varchar(dt1.in_lief_nr),'0') as in_lief_nr
,dt1.gp_ort
,dt1.werk_id
,dt1.loesch_fg
,COALESCE (dt1.in_lief_id_int, -1) AS in_lief_id_int
,dt1.subkategorie_1_id
,dt1.konzern_id
,TRIM(dt1.lief_name_1) || ' ' || LTRIM(to_varchar(dt1.in_lief_nr),'0') AS lief_name_lang
,0 AS zuordnen_fg
,0 AS zuordnung_loeschen_fg
FROM dbp_view.v_in_lieferant dt1
INNER JOIN  dbp_view.v_in_lieferant_ekorg_zu dt2
ON dt1.mandant_id = dt2.mandant_id
AND dt1.in_lief_id = dt2.in_lief_id
AND dt2.einkaeufer_grp_id IS NOT NULL

INNER JOIN dbp_view.v_in_l_ekorg dt3
ON dt2.mandant_id = dt3.mandant_id
AND dt2.einkaufsorganisation_id = dt3.einkaufsorganisation_id
AND dt3.sako_fg=1
-- Gibt es mehrere Einträge in LFM1 (in_lieferant_ekorg_zu) zu einem Lieferant
-- wird klienste EKORG verwendet
QUALIFY SUM(1) OVER (PARTITION BY dt1.mandant_id, dt1.in_lief_id ORDER BY dt2.einkaufsorganisation_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) =1
;