CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_EINKAEUFER_LDAP_ZU
      -- 15.01.2014 Zuordungstabelle Einkäufer (LDAP) zu Einkäufergruppe Lieferant bzw. Einkäufergruppe Material
      -- wird per Transaction Services gepflegt
      -- 05.02.2015 twie: Groß/kleinschreibung ldap an MSI anpassen wegen Abgleich im Cockpit
      -- 09.11.2015 twie: Einkäufergruppe nur als Zuordnung zum LDAP anzeigen, wenn die Einkäufergruppe in der Lookuptabelle auch als aktiv gekennzeichnet ist.
      -- 20.11.2015 twie: Korrektur zum 09.11. die Lookuptabelle mit aktiven EKGR beinhalte nur nationale EKGR, es muss mit UNION auch die Lookup für internat. EKGR aufgenommen werden.
      -- 07.12.2016 twie: SPEC0017788 EKG -1 ist nicht beschaffungsrelevant, wird in Pflegebericht auch ausgeschlossen

      (
      ma_ldap
      ,mandant_id
      ,einkaeufer_grp_id
      ,eigene_gruppe_fg
      ,hat_einkaeufer_grp_fg
      )
      AS

         SELECT -- alle LDAP
         SUBSTR(UPPER(v01.ma_ldap), 1,2) || SUBSTR(LOWER(v01.ma_ldap), 3,8)  AS ma_ldap,
         t2.mandant_id,
         t2.einkaeufer_bis_id AS einkaeufer_grp_id,
         t2.eigene_gruppe_fg,
         CASE WHEN t2.ma_ldap IS NOT NULL THEN 1 ELSE 0 END AS hat_einkaeufer_grp_fg

         FROM dbp_security.l_bis_ldap v01    --dbe_data_fed_bis für Tests

         LEFT JOIN
         ( --t2
         SELECT -- Zuordnungen LDAP <-> EKGR wenn vorhanden
         v02.ma_ldap,
         v02.mandant_id,
         v02.einkaeufer_bis_id,
         v02.eigene_gruppe_fg
         FROM dbp_security.bis_einkaeufer_ldap_zu v02  --dbe_data_fed_bis für Tests

         INNER JOIN
         ( --t3
         SELECT -- nur aktive nat. EKGR, ohne -1
         v03.mandant_id,
         v03.einkaeufer_grp_id
         FROM dbp_view.v_in_l_einkaeufer_grp v03
         WHERE  v03.aktiv_fg = 1
         AND v03.einkaeufer_grp_id <> '-1'

         UNION

         SELECT -- alle int. EKGR
         99 AS mandant_id,
         v04.einkaeufer_int_id AS einkaeufer_grp_id
         FROM dbp_view.v_in_l_einkaeufer_int v04
         ) t3
         ON  v02.mandant_id = t3.mandant_id
         AND v02.einkaeufer_bis_id = t3.einkaeufer_grp_id
         ) t2
         ON v01.ma_ldap = t2.ma_ldap
;