require_relative 'bplc'

class SMC

  def initialize()
    @addresses = 0
    @E = [{}]
    @S = []
    @M = {}
    @C = []

    @A = []
    @reserved = ["add", "sub", "div", "mul", "eq", "le", "lt", "ge", "gt", "neg", "assign", "if", "while", "print", "and", "or", "seq", "proc", "var", "const"]
  end

  def lengthC()
    @C.length
  end

  def lengthE()
    @E.length
  end

  def print_smc()
    puts("Ambiente      #{@E}")
    puts("Valor         #{@S}")
    puts("Controle      #{@C}")
    puts("Memoria       #{@M}")
    puts("Aux           #{@A}")
    puts()
  end

  def pushS(valor)
    @S.unshift(valor)
  end

  def pushC(controle)
    @C.unshift(controle)
  end

  def popS()
    @S.shift()
  end

  def popC()
    @C.shift()
  end

  def readM(variavel)
    bindable = @E[0][variavel]

    if bindable.id.eql? "value"
      return bindable.content
    end
    if bindable.id.eql? "proc"
      return bindable.content,bindable.formals
    end
    if bindable.id.eql? "func"
      return bindable.content,bindable.formals
    end
    @M[bindable.content]
  end

  def writeM(variavel, dado)
    endVar = @E[0][variavel].content()
    @M[endVar] = dado
  end

  def writeE(variavel, bindable)
    if (@reserved.include?(variavel))
      raise "Exception: Reserved word used as identifier."
    end

    new_env = Hash.new
    new_env = @E[0].clone

    if bindable.is_loc? # var decl
      bindable.setContent(@addresses)
      new_env[variavel] = bindable
      @E.unshift(new_env)
      @addresses += 1

    else # const decl
      new_env[variavel] = bindable
      @E.unshift(new_env)
    end

  end

  def writeECallable(variavel, callable)
    if (@reserved.include?(variavel))
      raise "Exception: Reserved word used as identifier."
    end

    new_env = Hash.new
    new_env = @E[0].clone

    new_env[variavel] = callable
    @E.unshift(new_env)

  end

  def topC()
    @C[0]
  end

  def popA()
    listaVar = @A.shift()
    for i in 0..(listaVar.length - 1)
      id = listaVar[i]
      cont = @E[0][id]
      if cont.kind_of?(Bindable)
        if cont.is_loc?
          @M.delete(cont.content)
        end
      end
      @E.shift
    end
  end

  def writeA(variavel)
    @A[0].unshift(variavel)
  end

  def pushA
    @A.unshift([])
  end

  def instantiated?(identifier)
    return @E[0].has_key?(identifier)
  end

  def const?(identifier)
    if @E[0].has_key?(identifier)
      bindable = @E[0][identifier]
      bindable.id == "value"
    else
      false
    end
  end

end