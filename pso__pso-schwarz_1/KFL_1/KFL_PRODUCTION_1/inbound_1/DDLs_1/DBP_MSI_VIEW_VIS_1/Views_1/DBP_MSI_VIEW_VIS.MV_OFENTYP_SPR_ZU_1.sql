CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_OFENTYP_SPR_ZU_1 as
   -- SPRACHE : Backplanung - Ofentyp
   -- (keine Mehrsprachigkeit)
   -- 2015KW26 : Backplanung KMO. Anpassung Joins/Bedingungen. Initial

   SELECT
   mandant_id, ofen_typ_id, ofen_typ_bez, spr_id
   FROM dbp_view.v_ofentyp_spr_zu_1
;