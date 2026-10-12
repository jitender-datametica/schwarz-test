CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.TBL_MV_MANDANT_1
-- 11.12.2012 A. Lipkin Initial
-- 04.12.2014 SROM Erweiterung mandant_id = 99 für Int. Mandant_1
-- 23.02.2015 twie: 99 wieder entfernt und eigene Lookup für Land_1 Einkäufergruppe mit mandant_id 99 angelegt
-- 12.04.2016 srom: AP0001972 mandant_id = 99 wieder eingebaut für int. Kennzahlen im Management Cockpit
-- 02.11.2016 twie: SPEC0016203 indiv. sort_id für BIS eingefügt
-- 24.01.2017 twie: Sortierung sort_bis gedreht
-- 03.01.2018 twie: SPEC0029243 Umbenennung 'international' zu 'International'
AS 
   SELECT
   mandant_id,
   mandant_bez,
   mandant_kbez,
   bis_sort_id,
   default_wrg
   FROM
   (
   SELECT
   mandant_id,
   mandant_bez,
   mandant_kbez,
   default_wrg,
   CASE WHEN mandant_id = 1 THEN 2 WHEN mandant_id = 3 THEN 3 WHEN mandant_id = 2 THEN 4 WHEN mandant_id = 7 THEN 5 WHEN mandant_id = 5 THEN 6 WHEN mandant_id = 8 THEN 7 WHEN mandant_id = 6 THEN 8 END AS bis_sort_id
   FROM dbp_view.v_mandant_1 v01);