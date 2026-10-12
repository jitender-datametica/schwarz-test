CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LEIST_EMPFAENGER_LDAP_ZU_1
-- Sicherheitsfilter auf VZ+GP_1 Ebene (JOIN über diese beiden Felder)
-- Daher können lagernummer, leist_empfaenger_sap_id entfallen
-- AP0016637, SPEC0020501, Spalte für das Auswertungsflag hinzugefügt
(
mandant_id
,wup_id
,nb_id
,ma_ldap
,gp_id
,leist_auswerteberechtigt_fg
)
AS
   SELECT
   mandant_id, wup_id, nb_id, ma_ldap, gp_id, leist_auswerteberechtigt_fg
   FROM dbp_security.leist_empfaenger_ldap_zu_1
   GROUP BY mandant_id
   ,wup_id
   ,nb_id
   ,ma_ldap
   ,gp_id
   ,leist_auswerteberechtigt_fg
;