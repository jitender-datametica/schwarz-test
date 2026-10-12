--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.vis_bestand_wg_log VALUES (date - ${LOOP_ID});
--
--Comment from validation checker
--error line 1 at position 73 unexpected ')'.
--
--translated statement
INSERT INTO DBP_ETL.vis_bestand_wg_log VALUES (date - ${LOOP_ID});

