	USE DbRecursosHumanos
	GO

	CREATE FUNCTION DBO.FnTotalDeudaEmpleado(@PNumeroDeEmpleado CHAR(7))
	RETURNS  DECIMAL(8,2)
	AS
	BEGIN
		DECLARE @VValorCredito DECIMAL(8,2)

		
		IF (SELECT  B.TipoDePlanilla FROM TblPersonal A
		INNER JOIN TblPlanillas B ON B.Planilla =A.Planilla  AND B.Empresa =A.Empresa
		WHERE A.NumeroDeEmpleado =@PNumeroDeEmpleado)='06'
		BEGIN
		
		END
		ELSE
		BEGIN
		SELECT  SUM(Valor) 
		FROM TblDescuentos A
		WHERE  Retencion IN (423,424)
		AND Fecha>=(SELECT   FechaDeIngreso FROM   DbRecursosHumanos.DBO.TblPersonal B WHERE B.NumeroDeEmpleado  =A.NumeroDeEmpleado AND B.NumeroDeEmpleado =@PNumeroDeEmpleado )
		AND A.NumeroDeEmpleado =@PNumeroDeEmpleado
		RETURN @VValorCredito
		END
	END
	
	USE DbRecursosHumanos
	GO
	CREATE FUNCTION DBO.FnTotalDeudaEmpleado( @PNumeroDeEmpleado CHAR(7))
	RETURNS  DECIMAL(8,2)
	AS
	BEGIN
	DECLARE @VValorCredito DECIMAL(8,2)
	SELECT ISNULL((SUM(Valor)),0)
	FROM TblOtrosDescuentos A
	WHERE LEFT(Retencion,1)='4'
	AND Fecha>=(SELECT  FechaDeIngreso FROM   DbRecursosHumanos.DBO.TblPersonal B WHERE B.NumeroDeEmpleado  =A.NumeroDeEmpleado AND B.NumeroDeEmpleado =@PNumeroDeEmpleado )
	AND CorrelativoDePago =0
	AND Retencion IN (423,424)
	AND A.NumeroDeEmpleado =@PNumeroDeEmpleado
	
	RETURN @VValorCredito
	END
	