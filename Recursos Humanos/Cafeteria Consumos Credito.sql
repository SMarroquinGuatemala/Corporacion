
	USE DbRecursosHumanos
	GO

	ALTER FUNCTION DBO.FnTotalDeudaEmpleado( @PNumeroDeEmpleado CHAR(7))
	RETURNS  DECIMAL(8,2)
	AS
	BEGIN
		DECLARE @VValorCredito DECIMAL(8,2)
		SELECT @VValorCredito= SUM(ValorCredito)  
		FROM SQLTRFCA6.DBADMINISTRACION.DBO.TblCafCompras A
		WHERE NumeroDeEmpleado =@PNumeroDeEmpleado
		AND Fecha>=(SELECT   FechaDeIngreso FROM   DbRecursosHumanos.DBO.TblPersonal B WHERE B.NumeroDeEmpleado  =A.NumeroDeEmpleado AND B.NumeroDeEmpleado=@PNumeroDeEmpleado )
		AND isAnulado =0

		RETURN @VValorCredito
	END
	