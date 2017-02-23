alter procedure SPSOFIA_RegistraPagoPoliza(@cuenta bigint,@importe float)
as
begin
	if (select count(1) from PagosPolizas where Cuenta=@cuenta)=0
		begin
			insert into PagosPolizas values(@cuenta,@importe,'Pago de tesoreria')
		end
	
end