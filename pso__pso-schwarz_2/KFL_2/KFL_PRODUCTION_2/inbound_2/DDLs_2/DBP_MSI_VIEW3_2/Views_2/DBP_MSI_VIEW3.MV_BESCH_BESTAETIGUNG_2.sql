CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_BESTAETIGUNG_2
(
 best_beleg_id
,ext_beleg_id
,best_beleg_pos_id
,bestaetigung_lfd_nr
,bestaetigung_typ_id
,dat_bestaetigung
,dat_lief_plan
,lief_beleg_id
,lief_beleg_pos_id
,mandant_id
,menge_bestaetigung
,menge_dispo
,zeit_bestaetigung
,zeit_lief_plan
,kj_lief_beleg
)
AS
   SELECT
   best_beleg_id, ext_beleg_id, best_beleg_pos_id, bestaetigung_lfd_nr, bestaetigung_typ_id, dat_bestaetigung, dat_lief_plan, lief_beleg_id, lief_beleg_pos_id, mandant_id, menge_bestaetigung, menge_dispo, zeit_bestaetigung, zeit_lief_plan, kj_lief_beleg
   FROM dbp_view.v_besch_bestaetigung_2
   WHERE extract(year from dat_bestaetigung) >= year(current_timestamp) - 2
;