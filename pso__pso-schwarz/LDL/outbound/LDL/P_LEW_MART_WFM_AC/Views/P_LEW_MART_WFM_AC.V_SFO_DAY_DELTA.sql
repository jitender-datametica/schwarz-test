/* #DescStart#
#$Revision: 9846 $, $LastChangedBy: mildorfj $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_sfo_day_delta (client_id, country_lidl_cd, store, receiptdate, item,
sfo_pieces_130_140, sfo_pieces_131_141, sfo_pieces_132_142, sfo_pieces_133_143, sfo_pieces_134_144, sfo_pieces_135_145,
sfo_pieces_136_146, sfo_pieces_137_147_0pv, sfo_pieces_137_147_pv, sfo_pieces_138_148, sfo_pieces_139_149,
sfo_pieces_150_160, sfo_pieces_151_161, sfo_pieces_152_162, sfo_value_130_140, sfo_value_131_141, sfo_value_132_142,
sfo_value_133_143, sfo_value_134_144, sfo_value_135_145, sfo_value_136_146, sfo_value_137_147_0pv, sfo_value_137_147_pv
, sfo_value_138_148, sfo_value_139_149, sfo_value_150_160, sfo_value_151_161, sfo_value_152_162, load_id) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_sfo_day_delta;