CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGER_EINHEITEN_TYP_2
(
mandant_id
,lagernummer_id
,wup_id
,nb_id
,lager_einheiten_typ
)
AS
   SELECT
   mandant_id, lagernummer_id, wup_id, nb_id, lager_einheiten_typ
   FROM dbp_view.v_l_lager_einheiten_typ_2
;