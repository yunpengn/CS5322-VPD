package system

type Mode string

var (
	Local      = register("local")
	Staging    = register("stg")
	Production = register("prd")
)

func register(name string) Mode {
	return Mode(name)
}
