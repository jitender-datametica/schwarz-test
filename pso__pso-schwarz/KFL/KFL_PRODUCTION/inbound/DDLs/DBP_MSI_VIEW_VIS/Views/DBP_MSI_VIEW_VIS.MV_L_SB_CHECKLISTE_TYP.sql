CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SB_CHECKLISTE_TYP as
   -- LOOKUP/SPRACHE Checklistentyp
   -- International (ohne mandant, ohne Sprache)
   -- 20150330 Initial

   SELECT
   sb_checkliste_typ_id, sb_checkliste_typ_bez
   FROM dbp_view.v_l_sb_checkliste_typ v01
;