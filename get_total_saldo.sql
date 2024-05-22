CREATE OR REPLACE FUNCTION public.get_total_saldo(
	p_id integer,
	p_fecha date)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	v_saldo double PRECISION;

BEGIN
    SELECT IFNULL(SUM(mov_valor)*-1,0) INTO v_saldo
	from movimiento
	WHERE mov_tipo = 'debito'
	AND cue_id = p_id
	AND mov_fecha = p_fecha;

  RETURN v_saldo;
END;
$BODY$;