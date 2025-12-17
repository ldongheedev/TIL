package javaTask; 

import javax.swing.*; 
import java.awt.*;    
import java.awt.event.*;
import java.io.*; // 파일 입출력(I/O) 확장을 위한 패키지
import java.util.*;
import java.util.List;

// 게임의 핵심 데이터와 판정 규칙을 관리하는 로직 클래스
// 제네릭과 컬렉션(ArrayList)을 활용하여 데이터를 관리함 (문제 조건 달성)
class GameLogic {
    private List<Integer> secretNumber; // 정답 숫자를 담는 리스트 (제네릭 활용)
    private ArrayList<String> gameHistory; // 사용자의 추측 이력을 저장하는 리스트
    private static final int DIGIT = 4; // 게임 난이도 (4자리) 설정

    public GameLogic() {
        secretNumber = generateSecretNumber();
        gameHistory = new ArrayList<>();
    }

    // Collections.shuffle을 이용한 중복 없는 난수 생성 알고리즘
    // 수업 시간에 배운 컬렉션 프레임워크의 유틸리티 기능을 실제 로직에 활용함
    private List<Integer> generateSecretNumber() {
        List<Integer> numbers = new ArrayList<>();
        for (int i = 1; i <= 9; i++) {
            numbers.add(i);
        }
        Collections.shuffle(numbers); // 리스트의 요소를 무작위로 섞음
        return numbers.subList(0, DIGIT); // 섞인 숫자 중 앞의 4개만 선택
    }

    // 사용자 입력값 검증 및 예외 처리
    // 잘못된 입력 시 예외를 던져 프로그램의 중단을 막고 안정성을 확보함
    public List<Integer> parseGuess(String guess) throws IllegalArgumentException {
        if (guess.length() != DIGIT) {
            throw new IllegalArgumentException(DIGIT + "자리의 숫자를 입력해야 합니다.");
        }
        
        List<Integer> guessList = new ArrayList<>();
        for (char c : guess.toCharArray()) {
            if (!Character.isDigit(c)) throw new IllegalArgumentException("숫자만 입력 가능합니다.");
            int digit = Character.getNumericValue(c);
            if (digit < 1 || digit > 9) throw new IllegalArgumentException("1~9 사이의 숫자여야 합니다.");
            if (guessList.contains(digit)) throw new IllegalArgumentException("중복된 숫자가 있습니다.");
            guessList.add(digit);
        }
        return guessList;
    }

    // 스트라이크(S)와 볼(B)을 판정하는 핵심 알고리즘
    public String checkGuess(List<Integer> guessList) {
        int strike = 0, ball = 0;
        for (int i = 0; i < DIGIT; i++) {
            if (guessList.get(i).equals(secretNumber.get(i))) strike++; // 숫자와 위치가 모두 일치
            else if (secretNumber.contains(guessList.get(i))) ball++;   // 숫자만 포함됨
        }

        String result = (strike == DIGIT) ? DIGIT + " Strike! 정답!" : strike + "S " + ball + "B";
        if (strike == 0 && ball == 0) result = "Out";

        // StringBuilder를 사용하여 메모리 효율적으로 게임 이력을 문자열로 변환 후 저장
        StringBuilder sb = new StringBuilder();
        for(Integer d : guessList) sb.append(d);
        gameHistory.add(sb.toString() + " -> " + result);
        
        return result;
    }
    
    public List<Integer> getSecretNumber() { return secretNumber; }
    public ArrayList<String> getGameHistory() { return gameHistory; }
}

// 실시간 경과 시간 측정을 위한 멀티스레드 클래스
// 수업 외 기술인 Thread를 상속받아 동적인 UI 기능을 구현함
class GameTimer extends Thread {
    private JLabel timerLabel;
    private int seconds = 0;
    private volatile boolean isRunning = true; // 스레드의 안전한 종료를 위한 제어 변수

    public GameTimer(JLabel timerLabel) { this.timerLabel = timerLabel; }
    public void stopTimer() { isRunning = false; }

    @Override
    public void run() {
        while (isRunning) {
            try {
                Thread.sleep(1000); // 1초 간격으로 대기
                seconds++;
                // 작업 스레드에서 GUI를 안전하게 갱신하기 위해 invokeLater 사용
                SwingUtilities.invokeLater(() -> timerLabel.setText("경과 시간: " + seconds + "초"));
            } catch (InterruptedException e) { break; }
        }
    }
}

// 화면 구성 및 이벤트 제어를 담당하는 메인 GUI 클래스
// JFrame 상속 및 새로운 컴포넌트(JScrollPane, JOptionPane) 활용
public class JavaTask extends JFrame { 
    private JTextField inputField; // 사용자 입력 필드
    private JButton guessButton;   // 추측 버튼
    private JTextArea resultArea;  // 결과 출력창
    private JLabel statusLabel, timerLabel;
    private JScrollPane scrollPane; // 새로운 컴포넌트: 기록 누적 시 스크롤 기능 제공

    private GameLogic logic;
    private GameTimer timer;

    public JavaTask() { 
        setTitle("자바응용 기말프로젝트 - 4자리 숫자야구");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(400, 550);
        setLayout(new BorderLayout(10, 10)); // 레이아웃 매니저 설정

        // 상단 영역: 상태 메시지 및 실시간 타이머 배치
        JPanel topPanel = new JPanel(new GridLayout(2, 1));
        statusLabel = new JLabel("숫자를 맞춰보세요!", SwingConstants.CENTER);
        statusLabel.setFont(new Font("맑은 고딕", Font.BOLD, 18));
        timerLabel = new JLabel("경과 시간: 0초", SwingConstants.CENTER);
        topPanel.add(statusLabel);
        topPanel.add(timerLabel);
        add(topPanel, BorderLayout.NORTH);

        // 중앙 영역: JTextArea에 JScrollPane을 적용하여 많은 데이터 확인 가능 (조건 달성)
        resultArea = new JTextArea();
        resultArea.setEditable(false);
        scrollPane = new JScrollPane(resultArea); 
        add(scrollPane, BorderLayout.CENTER);

        // 하단 영역: 입력창과 버튼 배치
        JPanel bottomPanel = new JPanel(new BorderLayout());
        inputField = new JTextField();
        guessButton = new JButton("추측");
        JButton newGameBtn = new JButton("새 게임");
        
        JPanel btnWrap = new JPanel(new GridLayout(1, 2));
        btnWrap.add(guessButton);
        btnWrap.add(newGameBtn);
        
        bottomPanel.add(inputField, BorderLayout.CENTER);
        bottomPanel.add(btnWrap, BorderLayout.EAST);
        add(bottomPanel, BorderLayout.SOUTH);

        // 버튼 클릭 시 람다식을 이용한 이벤트 처리
        guessButton.addActionListener(e -> handleGuess());
        newGameBtn.addActionListener(e -> startNewGame());

        setVisible(true);
        setLocationRelativeTo(null); // 실행 시 화면 중앙 정렬
    }

    // 게임 시작 시 데이터 초기화 및 타이머 스레드 시작
    private void startNewGame() {
        if (timer != null) timer.stopTimer();
        logic = new GameLogic();
        resultArea.setText("--- 게임 시작 ---\n");
        timer = new GameTimer(timerLabel);
        timer.start(); // 스레드 가동
        guessButton.setEnabled(true);
    }

    // 추측 버튼 클릭 시 판정 및 결과 출력 흐름 제어
    private void handleGuess() {
        try {
            String input = inputField.getText();
            String result = logic.checkGuess(logic.parseGuess(input));
            resultArea.append(input + " : " + result + "\n");
            inputField.setText("");
            
            if (result.contains("정답")) {
                timer.stopTimer(); // 정답 시 타이머 정지
                guessButton.setEnabled(false);
                saveLog(); // 파일 입출력 확장 기능 실행
            }
        } catch (Exception ex) {
            // 새로운 컴포넌트: JOptionPane을 사용한 사용자 알림 팝업 (조건 달성)
            JOptionPane.showMessageDialog(this, ex.getMessage(), "오류", JOptionPane.ERROR_MESSAGE);
        }
    }

    // 파일 입출력(I/O) 확장: 게임 로그 저장 및 인코딩 문제 해결
    // 기존 CSV 읽기 학습을 확장하여, 데이터를 파일로 출력하고 누적 기록(Append)함
    // 한글 깨짐 방지를 위해 UTF-8 형식을 명시적으로 지정
    private void saveLog() {
        File file = new File("baseball_log.txt");
        // try-with-resources 문법으로 스트림을 안전하게 자동 반납함
        try (BufferedWriter bw = new BufferedWriter(
                new OutputStreamWriter(new FileOutputStream(file, true), "UTF-8"))) {
            
            bw.write("\n[게임 종료 기록 - " + new Date() + "]\n");
            bw.write("정답 숫자: " + logic.getSecretNumber() + "\n");
            for (String h : logic.getGameHistory()) bw.write(h + "\n");
            bw.write("--------------------------\n");
            
            JOptionPane.showMessageDialog(this, "게임 기록이 'baseball_log.txt'에 저장되었습니다.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // Swing GUI의 안정적 실행을 위해 Event Dispatch Thread에서 호출
        SwingUtilities.invokeLater(JavaTask::new); 
    }
}