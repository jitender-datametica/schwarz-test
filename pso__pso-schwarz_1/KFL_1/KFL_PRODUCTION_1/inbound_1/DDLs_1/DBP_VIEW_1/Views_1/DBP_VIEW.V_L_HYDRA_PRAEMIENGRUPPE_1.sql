CREATE OR REPLACE VIEW DBP_VIEW.V_L_HYDRA_PRAEMIENGRUPPE_1 AS 
    SELECT 
        mandant_id,
        pers_teilbereich_id,
        praemiengrp_id,
        praemiengrp_bez

FROM DBP_DATA.L_HYDRA_PRAEMIENGRUPPE_1 ;