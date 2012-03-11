numrows = 5
numcols = 4

formfields = ["Placa","Marca","Modelo"]


doctype 5
html ->
  head ->
    meta charset: "utf-8"
    title "Controle de Fluxo Interno | MackPark"
    link rel: "stylesheet", href: "index.css"
    script src: "js/jquery-1.7.1.min.js"
    script src: "js/jquery-ui-1.8.18.custom.min.js"

  body ->
    form target:"#", ->
      for field in formfields
        label for:"#{field}", -> 
          span "#{field}"
          input type:"text", id:"#{field}", name: "#{field}"
      input type:"submit", value:"Novo Carro"
      hr()
      ul "#novo-carro-container", ->
        h2 "Entrada"
      ul "#apagar-carro-container", ->
        h2 "Saída"

    h1 "MackPark - Controle de entrada e saída de carros"

    div id:"field-wrapper", ->

      div id:"placeholder-wrapper", ->
        for i in [1..numcols]
          ul id:"col#{i}", class:"placeholder-col", ->
            h2 "Fileira #{i}"
            for j in [1..numrows]
              li class:"placeholder-cell", ->
                span "#{i}-#{j}"

      div id:"draggable-wrapper", ->
        for i in [1..numcols]
          ul id:"col#{i}", class:"col", ->

            # Criar carros de exemplo
            # for j in [1..numrows]
            #   li class:"cell", ->
            #     dl ->
            #       dt "Placa"
            #       dd "ABC #{i}00#{j}"
            #       dt "Marca"
            #       dd "Ford"
            #       dt "Modelo"
            #       dd "Focus"

    coffeescript ->
      $ ->
        ###
        #Sortables
        ###

        $("#novo-carro-container").sortable
          connectWith: ".col"

        $("#apagar-carro-container").sortable
          receive: (event, ui) ->
            $(ui.item[0]).fadeOut "slow", ->
              $(this).remove()

        $(".col").sortable
          connectWith: [".col", "#apagar-carro-container"]
          cursor: "move"


        ###
        #Form
        ###
        $("form").submit (event) ->
          event.preventDefault()

          novoCarro = $("<li/>")
            .hide()
            .addClass("cell")
            .append("<dl/>")
          lista = novoCarro.find "dl"

          inputs = $(@).find("input[type=text]")

          for input in inputs
            lista.append $("<dt>#{input.name}</dt><dd>#{input.value}</dd>")
            $(input).val("")

          $("#novo-carro-container").append(novoCarro)
          novoCarro.fadeIn("slow")