CREATE OR REPLACE VIEW DBP_VIEW.V_ART_GP_VERHANDLUNG_ZU AS 
    SELECT 
        mandant_id,
        art_id,
        gp_id,
        ivn_gruppe_id,
        ivn_verhandlungs_cluster_id,
        ivn_sortimentsgruppe_id,
        quellsystem_id
FROM DBP_DATA.ART_GP_VERHANDLUNG_ZU ;