CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_BIS_LDAP_2
   -- 15.01.2015 Lookuptabelle für Attribut Einkäufer (LDAP)
   -- Dieses wird mittels Transaction Services in einer Securitytabelle gespeichert
   -- 05.02.2015 twie: Groß/kleinschreibung ldap an MSI anpassen wegen Abgleich im Cockpit

   (
   ma_ldap
   )
   AS
      SELECT SUBSTR(UPPER(ma_ldap), 1,2) || SUBSTR(LOWER(ma_ldap), 3,8)  AS ma_ldap
      FROM dbp_security.l_bis_ldap_2
;