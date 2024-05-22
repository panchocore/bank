CREATE OR REPLACE FUNCTION get_saldo_inicial(p_id integer)
    RETURNS integer AS $$
DECLARE
	v_saldo double PRECISION;
	v_s double PRECISION;

BEGIN
    SELECT ifnull(count(mov_saldo),0) INTO v_s
	from movimiento
	WHERE cue_id = id;
	
	IF v_s = 0 THEN
		SELECT cue_saldo_inicial INTO v_saldo
		FROM cuenta
		WHERE cue_id = id;
	ELSE
		SELECT mov_saldo INTO v_saldo
		from movimiento
		WHERE cue_id = id
		ORDER BY mov_id desc
		LIMIT 1;
   END IF;

  RETURN v_saldo;
END;
$$ LANGUAGE plpgsql;
