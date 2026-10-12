CREATE OR REPLACE VIEW DBP_VIEW.V_IN_QUAL_MELDUNG_DET AS 
    SELECT 
        mandant_id
        ,qual_meldung_id
        ,qual_meldung_pos_id
        ,problemcode_id
        ,katalogart_id_pc
        ,codegruppe_id_pc
        ,katalogart_id_ot
        ,codegruppe_id_ot
        ,pruefcode_id_ot


FROM DBP_DATA.in_qual_meldung_det ;