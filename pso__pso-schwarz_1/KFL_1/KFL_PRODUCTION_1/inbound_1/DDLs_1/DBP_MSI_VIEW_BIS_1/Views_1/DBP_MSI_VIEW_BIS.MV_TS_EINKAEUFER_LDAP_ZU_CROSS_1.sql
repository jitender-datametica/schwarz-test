CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_TS_EINKAEUFER_LDAP_ZU_CROSS_1
-- Cross Join zwischen Einkäufergruppe Lieferant und Einkäufer (LDAP) als Auswahlmöglichkeit im Transaction Bericht
-- Es werden nur Kombinationen mit dem ldap des angemeldeten Users angezeigt
-- Die tatsächlich abgespeicherten Zuordungen werden über mv_einkaeufer_ldap_zu_1 angezeigt
-- 05.02.2015 twie: Groß/kleinschreibung ldap an MSI anpassen wegen Abgleich im Cockpit
-- 19.02.2015 twie: Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)
-- 09.11.2015 twie: auf aktive EKGR filtern (aktiv_fg = 0 sind im SAP gelöscht)
-- 07.12.2016 twie: SPEC0017788 Filter auf EKGR aus mv_l_einkaeufer_grp_1 übernommen

(
ma_ldap
,mandant_id
,einkaeufer_grp_id
,eigene_gruppe_fg
,hat_einkaeufer_grp_fg
,belegt_eigene_gruppe_fg
)
AS

   SELECT  SUBSTR(UPPER(t3.ma_ldap), 1,2) || SUBSTR(LOWER(t3.ma_ldap), 3,8)  AS ma_ldap,
   t3.mandant_id,
   t3.einkaeufer_grp_id,
   COALESCE(v05.eigene_gruppe_fg,0),
   CASE WHEN v05.einkaeufer_bis_id IS NOT NULL THEN 1 ELSE 0 END AS hat_einkaeufer_grp_fg,
   CASE WHEN v06.eigene_gruppe_fg = 1 THEN 1 ELSE 0 END AS belegt_eigene_gruppe_fg
   FROM
   ( --t3
   SELECT v01.ma_ldap,
   t2.mandant_id,
   t2.einkaeufer_grp_id
   FROM dbp_security.l_bis_ldap_1 v01  --dbe_data_fed_bis

   CROSS JOIN

   -- Dies entspricht der Sicht durch die View mv_l_einkaeufer_grp_1
   -- Die internationalen Einkäufer und nationalen Gruppen werden zusammen dargestellt
   -- In den MSI Berichten gibt es ein Attribut 'Einkäufergruppe Lieferant'
   (--t2
   SELECT mandant_id,
   einkaeufer_grp_id
   FROM (
   SELECT 99 AS mandant_id,
   v02.einkaeufer_int_id AS einkaeufer_grp_id
   FROM dbp_view.v_in_l_einkaeufer_int_1 v02
   ) t0

   UNION

   SELECT mandant_id,
   einkaeufer_grp_id
   FROM (
   SELECT v03.mandant_id,
   v03.einkaeufer_grp_id
   FROM dbp_view.v_in_l_einkaeufer_grp_1 v03
   WHERE v03.aktiv_fg = 1
   AND v03.einkaeufer_grp_id <> '-1'
   AND (v03.mandant_id <> 1
   OR (v03.mandant_id = 1 AND SUBSTR( v03.einkaeufer_grp_id, 1, 1) = 'S' ))
   ) t1_1
   ) t2

   ) t3
   INNER JOIN dbp_msi.akt_msi_user_1 v04
   ON t3.ma_ldap = v04.user_id
   LEFT JOIN dbp_security.bis_einkaeufer_ldap_zu_1 v05  --dbe_data_fed_bis

   ON t3.mandant_id = v05.mandant_id
   AND t3.ma_ldap = v05.ma_ldap
   AND t3.einkaeufer_grp_id = v05.einkaeufer_bis_id
   LEFT JOIN dbp_security.bis_einkaeufer_ldap_zu_1 v06  --dbe_data_fed_bis

   ON t3.mandant_id = v06.mandant_id
   AND t3.ma_ldap <> v06.ma_ldap
   AND t3.einkaeufer_grp_id = v06.einkaeufer_bis_id

;