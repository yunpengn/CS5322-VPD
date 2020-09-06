package logging

import (
	"bufio"
	"io"
	"log"
	"os"

	"github.com/yunpengn/CS5322-VPD/common/system"
)

type Logger struct {
	logger *log.Logger
}

const (
	defaultLog      = "app.log"
	defaultErrorLog = "err.log"
)

var (
	LogWriter io.Writer
	ErrWriter io.Writer
)

func Init(mode system.Mode) {
	if mode == system.Local {
		LogWriter = os.Stdout
		ErrWriter = os.Stderr
	}

	file, _ := os.Create(defaultLog)
	LogWriter = bufio.NewWriter(file)

	file, _ = os.Create(defaultErrorLog)
	ErrWriter = bufio.NewWriter(file)
}

// NewLogger creates a new logger.
func NewLogger(tag string) *Logger {
	return &Logger{
		logger: log.New(LogWriter, tag, log.LstdFlags),
	}
}

// Print prints a new line of log message.
func (l *Logger) Print(format string, obj ...interface{}) {
	l.logger.Printf(format+"\n", obj...)
}
