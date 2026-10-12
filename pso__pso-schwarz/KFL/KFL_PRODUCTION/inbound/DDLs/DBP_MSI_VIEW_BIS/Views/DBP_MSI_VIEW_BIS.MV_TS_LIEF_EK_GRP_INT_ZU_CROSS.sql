CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_TS_LIEF_EK_GRP_INT_ZU_CROSS
-- Cross Join zwischen Einkäufergruppe Lieferant und Lieferant als Auswahlmöglichkeit im Transaction Bericht
-- Es werden nur Kombinationen zu Einkäufergruppen angezeigt, die der angemeldete User als eigene Gruppe ausgewählt hat
-- Es werden nur Kombinationen mit Lieferanten angezeigt, die dem User schon zugeordnet sind, oder noch gar niemandem
-- Lieferanten, die anderen Usern zugeordnet sind (über deren eigene Eink.gr.) werden hier nicht angezeigt
-- Die tatsächlich abgespeicherten Zuordungen werden über mv_lief_einkaeuf_grp_int_zu bzw. mv_lief_einkaeuf_grp_zu angezeigt
-- 19.02.2015 twie: Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)
-- 07.12.2016 twie: SPEC0017788 Lieferanten ohne EKGR (entspr. EKG -1) sind nicht beschaffungsrelevant

(
grp_mandant_id
,einkaeufer_grp_id
,lief_mandant_id
,in_lief_id
,hat_lieferant_fg
)
AS

   SELECT t1.grp_mandant_id,
   COALESCE(t1.einkaeufer_grp_id,t2.einkaeufer_bis_id) AS einkaeufer_grp_id,
   t1.lief_mandant_id,
   t1.in_lief_id,
   t1.hat_lieferant_fg

   FROM

   -- Alle bereits dem LDAP User zugeordneten Lieferanten/Int. Einkäufergruppen
   -- dazu alle noch nicht zugeordneten Lieferanten
   ( --t1
   SELECT  99 AS grp_mandant_id,
   v04.einkaeufer_int_id AS einkaeufer_grp_id,
   v01.mandant_id AS lief_mandant_id,
   v01.in_lief_id,
   CASE WHEN v04.in_lief_id IS NULL THEN 0 ELSE 1 END AS hat_lieferant_fg

   FROM dbp_view.v_in_lieferant v01
   INNER JOIN dbp_view.v_in_lieferant_ekorg_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.in_lief_id = v02.in_lief_id
   AND v02.einkaeufer_grp_id IS NOT NULL
   INNER JOIN dbp_view.v_in_l_ekorg v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.einkaufsorganisation_id = v03.einkaufsorganisation_id
   AND v03.sako_fg=1
   LEFT JOIN dbp_msi_view_bis.ts_einkaeufer_int_lief_zu v04
   ON v01.mandant_id = v04.mandant_id
   AND v01.in_lief_id = v04.in_lief_id
   LEFT JOIN dbp_security.bis_einkaeufer_ldap_zu v05      --dbe_data_fed_bis

   ON CAST(v04.einkaeufer_int_id AS CHAR(10)) = v05.einkaeufer_bis_id
   LEFT JOIN dbp_msi.akt_msi_user v06
   ON v05.ma_ldap = v06.user_id

   -- Es werden nur die eigenen Zuordnungen angezeigt und die noch nicht zugeordneten Lieferanten
   -- Ein Lieferant soll nur einem internationalen Einkäufer zugeordnet werden.
   -- Jeder LDAP User verwaltet nur die in seiner Int. EK-Gruppe zugeordneten Lieferanten
   WHERE (v05.mandant_id = 99 AND v05.eigene_gruppe_fg = 1 AND v06.user_id IS NOT NULL) -- eigene, zugeordnete Lieferanten
   OR (v01.mandant_id,v01.in_lief_id) NOT IN (SELECT mandant_id,
   in_lief_id FROM dbp_msi_view_bis.ts_einkaeufer_int_lief_zu)  -- noch freie Lieferanten

  -- Gibt es mehrere Einträge in LFM1 (in_lieferant_ekorg_zu) zu einem Lieferant
  -- wird kleinste EKORG verwendet
  --WHERE t01.in_lief_id = 1255
  QUALIFY SUM(1) OVER (PARTITION BY v01.mandant_id, v01.in_lief_id ORDER BY v02.einkaufsorganisation_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) = 1
  ) t1
   CROSS JOIN

   -- Alle dem LDAP User zugeordneten eigenen Int. Einkäufergruppen, damit im Pflegebericht alle möglichen Kombinationen angezeigt werden
   ( --t2
   SELECT v07.einkaeufer_bis_id

   FROM dbp_security.bis_einkaeufer_ldap_zu v07        --dbe_data_fed_bis

   INNER JOIN dbp_msi.akt_msi_user v08
   ON v07.ma_ldap = v08.user_id
   WHERE v07.mandant_id = 99
   AND v07.eigene_gruppe_fg = 1
   AND v08.user_id IS NOT NULL
   ) t2

   GROUP BY 1,2,3,4,5
;