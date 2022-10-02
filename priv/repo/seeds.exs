alias Bear.Tax
alias Bear.Repo

%Tax{name: "Monthly tax", type: "XPTO-A", amount: Decimal.new("123.21")} |> Repo.insert!()
%Tax{name: "Quarterly tax", type: "XPTO-B", amount: Decimal.new("456.32")} |> Repo.insert!()
%Tax{name: "Monthly tax", type: "XPTO-C", amount: Decimal.new("789.43")} |> Repo.insert!()
%Tax{name: "Quarterly tax", type: "XPTO-D", amount: Decimal.new("987.54")} |> Repo.insert!()
%Tax{name: "Monthly tax", type: "XPTO-E", amount: Decimal.new("654.65")} |> Repo.insert!()
%Tax{name: "Quarterly tax", type: "XPTO-F", amount: Decimal.new("321.76")} |> Repo.insert!()
