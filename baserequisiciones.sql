select *  from BitacoraPagoRequisicionesIndividual

--update ['030616$'] set [Fecha de Pago]='31-12-2015'
--	where [Póliza Pagada]='q'

--update ['030616$'] set [Fecha de Pago]=null
--	where [Póliza Pagada]='No'

insert into BitacoraPagoRequisicionesIndividual(CuentaCteId,Nombre,Poliza,prima,primaneta,udi,aseguradoraid,empresaid,pagada,cobrada,fechapagoreal,init)
select b.contrato
	  ,b.Nombre
	  ,b.[Póliza]
	  ,b.[Prima Total]
	  ,b.[Prima Neta]
	  ,b.[Monto UDI]
	  ,a.AseguradoraKey
	  ,e.EmpresaKey
	  ,(case b.[Póliza Pagada] when 'No' then 0 else 1 end) 'pagada' 
	  ,0 'cobrada'
	  ,b.[Fecha de Pago]
	  ,getdate()
	from ['030616$'] b
		inner join Aseguradora a with(nolock) on b.Aseguradora=a.AseguradoraDsc
		inner join Empresa e with(nolock) on b.[Empresa Actual]=e.EmpresaDsc
	order by b.[Fecha de Pago]


	--select distinct Aseguradora from ['030616$']

	--select * from Aseguradora

	--select distinct [Empresa Actual] from ['030616$']

	--select * from Empresa