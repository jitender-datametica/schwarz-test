CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_EINKAEUFER_BIS_SPR_ZU_CZ
      -- 16.06.2014 twie: Sprachtabelle für Attribut Einkäufergruppe Material. Dieses fasst nat. und int. Eink.gruppen zusammen aus 2 Tabellen.
      -- Somit können nat. und int. EKGR über das gleiche Attribut gesteuert werden. Für die int. wird die 99 als Mandant erfunden.
      -- Funktioniert analog der Einkäufergruppe Lieferant (mv_einkaeufer_grp_spr_zu) mit den gleichen Einträgen, nur diese sind nicht dem Lieferant sondern dem Material zugordnet
      -- 09.11.2015 twie: auf aktive EKGR filtern (aktiv_fg = 0 sind im SAP gelöscht)
      -- 20.09.2016 twie: SPEC0014806 Dummy EKGR - 1für DE ausgeben

      (
      mandant_id
      ,einkaeufer_bis_id
      ,einkaeufer_bis_bez
      )
      AS

         SELECT mandant_id,
         einkaeufer_bis_id,
         einkaeufer_bis_bez
         FROM
         (

         SELECT
         99 AS mandant_id,
         einkaeufer_bis_int_id AS einkaeufer_bis_id,
         einkaeufer_bis_int_name AS einkaeufer_bis_bez
         FROM dbp_view.v_in_l_einkaeufer_bis_int
         ) t0

         UNION

         SELECT *
         FROM
         (
         SELECT
         v01.mandant_id,
         v01.einkaeufer_grp_id AS einkaeufer_bis_id,
         CAST(v02.einkaeufer_grp_bez AS VARCHAR(50)) AS einkaeufer_bis_bez
         FROM dbp_view.v_in_l_einkaeufer_grp v01
         INNER JOIN dbp_view.v_in_einkaeufer_grp_spr_zu v02
         ON v01.mandant_id = v02.mandant_id
         AND v01.einkaeufer_grp_id = v02.einkaeufer_grp_id
         WHERE v02.spr_id = 124
         AND v01.aktiv_fg = 1
         AND  (v01.mandant_id <> 1
         OR (v01.mandant_id = 1 AND (SUBSTR(v01.einkaeufer_grp_id, 1, 1) = 'S' OR v01.einkaeufer_grp_id = '-1')))
         ) t1;