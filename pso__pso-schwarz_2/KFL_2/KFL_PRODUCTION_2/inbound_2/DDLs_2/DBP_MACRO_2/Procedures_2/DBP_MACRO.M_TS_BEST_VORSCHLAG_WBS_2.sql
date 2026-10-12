CREATE OR REPLACE PROCEDURE DBP_MACRO.M_TS_BEST_VORSCHLAG_WBS(MANDANT_ID FLOAT, WUP_ID FLOAT, NB_ID FLOAT, ART_ID FLOAT, DAT_AUSFUEHRUNG VARCHAR, MENGE_WBS_FINAL FLOAT, CHECK_VZ_FG FLOAT, CHECK_WUP_FG FLOAT, STATUS_VERARBEITUNG FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS 

$$

var sql_stmt = `MERGE INTO DBP_DATA.ts_best_vorschlag_wbs_2 as target
				USING (
				SELECT 
               		? AS mandant_id
					, ? AS wup_id
					, ? AS nb_id
					, ? AS art_id
					, ? AS dat_ausfuehrung
					, ? AS menge_wbs_final
					, ? AS check_vz_fg
					, ? AS check_wup_fg
					, ? AS status_verarbeitung
				) AS source
				ON target.mandant_id = source.mandant_id
					AND target.wup_id = source.wup_id
					AND target.nb_id = source.nb_id
					AND target.art_id = source.art_id
					AND target.dat_ausfuehrung = source.dat_ausfuehrung
				WHEN MATCHED THEN
					UPDATE SET target.menge_wbs_final = source.menge_wbs_final
							, target.check_vz_fg = source.check_vz_fg
							, target.check_wup_fg = source.check_wup_fg
				WHEN NOT MATCHED THEN
					INSERT (mandant_id, wup_id, nb_id, art_id, dat_ausfuehrung, menge_wbs_final, check_vz_fg, check_wup_fg, status_verarbeitung)
					VALUES (
						source.mandant_id
						, source.wup_id
						, source.nb_id
						, source.art_id
						, source.dat_ausfuehrung
						, source.menge_wbs_final
						, source.check_vz_fg
						, source.check_wup_fg
						, source.status_verarbeitung)`;

snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID, WUP_ID, NB_ID, ART_ID, DAT_AUSFUEHRUNG, MENGE_WBS_FINAL, CHECK_VZ_FG, CHECK_WUP_FG, STATUS_VERARBEITUNG].map(function(x){return x === undefined ? null : x})
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
;