CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_STUECKLISTE_1
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,stueckliste_id
,stueckliste_typ_id
,in_art_id
,werk_id
,menge_basis
)
AS
   SELECT mandant_id, stueckliste_id, stueckliste_typ_id, flw_art_id AS in_art_id, werk_id, menge_basis

   FROM dbp_view.v_flw_stueckliste_1;