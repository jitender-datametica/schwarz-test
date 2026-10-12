CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LIEFERANT_CZ_GRP
-- 26.10.2011 system_id entfernt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 07.03.2013 twie: aenderung in Datenmodell durch SAKO, lief_name aufgeteilt in lief_name_1 und lief_name_2
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014

( in_lief_grp_id
,in_lief_grp_mandant_id
-- ,system_id
,lief_name
,in_lief_nr
,gp_ort
,lief_betreuer_id
)
AS
   SELECT
   --  neue Ids fuer Lookup-Table
   v00.flw_lief_id AS in_lief_grp_id, v00.mandant_id AS in_lief_grp_mandant_id, CAST(TRIM(v00.lief_name_1) || ' ' ||  TRIM(v00.lief_name_2)AS VARCHAR(161)) AS lief_name -- beide Felder haben varchar(80)
   , COLLATE(LTRIM(COLLATE(v00.flw_lief_nr,''),'0'), 'en-ci') AS in_lief_nr,
   v00.gp_ort  AS gp_ort, v00.lief_betreuer_id

   FROM dbp_view.v_flw_lieferant  v00
   INNER  JOIN dbp_view.v_flw_lieferant_ekorg_zu dt2
   ON v00.mandant_id = dt2.mandant_id
   AND v00.flw_lief_id = dt2.flw_lief_id
   AND dt2.einkaufsorganisation_id IN (5000,5013,5014)
   WHERE
   -- waehlen Lieferant  nur fuer Deutschland
   v00.flw_lief_id_cz =0
   OR  ( v00.mandant_id = 1
   AND v00.flw_lief_id_cz > 0 );