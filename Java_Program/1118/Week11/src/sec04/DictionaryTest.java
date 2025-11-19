package sec04;
import java.util.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

class MyDictionary {
    private HashMap<String, String> dic;

    public MyDictionary() {
        dic = new HashMap<>();
    }

    public String search(String word) {
        return dic.get(word);
    }

    public boolean addWord(String eng, String kor) {
        dic.put(eng, kor);
        return true;
    }

    public boolean removeWord(String eng) {
        return dic.remove(eng) != null;
    }

    public boolean updateWord(String eng, String newKor) {
        if(dic.containsKey(eng)) {
            dic.put(eng, newKor);
            return true;
        }
        return false;
    }

    public String getAllWords() {
        if(dic.isEmpty()) return "사전이 비어 있습니다.";
        StringBuilder sb = new StringBuilder("=== 전체 단어 목록 ===\n");
        for(String key : dic.keySet()) {
            sb.append(key).append(" : ").append(dic.get(key)).append("\n");
        }
        return sb.toString();
    }
}

public class DictionaryTest extends JFrame {
    private MyDictionary dictionary;
    private JTextField engField, korField;
    private JTextArea outputArea;

    public DictionaryTest() {
        dictionary = new MyDictionary();

        setTitle("한영 사전 (GUI 버전)");
        setSize(500, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // 입력 패널
        JPanel inputPanel = new JPanel(new GridLayout(2,2));
        inputPanel.add(new JLabel("영어 단어:"));
        engField = new JTextField();
        inputPanel.add(engField);
        inputPanel.add(new JLabel("뜻(한국어):"));
        korField = new JTextField();
        inputPanel.add(korField);

        // 버튼 패널
        JPanel buttonPanel = new JPanel(new FlowLayout()); // FlowLayout으로 변경
        Dimension btnSize = new Dimension(70, 30); // ✅ 버튼 크기 설정

        JButton addBtn = new JButton("추가");
        addBtn.setPreferredSize(btnSize);

        JButton searchBtn = new JButton("검색");
        searchBtn.setPreferredSize(btnSize);

        JButton updateBtn = new JButton("수정");
        updateBtn.setPreferredSize(btnSize);

        JButton removeBtn = new JButton("삭제");
        removeBtn.setPreferredSize(btnSize);

        JButton printBtn = new JButton("전체");
        printBtn.setPreferredSize(btnSize);

        buttonPanel.add(addBtn);
        buttonPanel.add(searchBtn);
        buttonPanel.add(updateBtn);
        buttonPanel.add(removeBtn);
        buttonPanel.add(printBtn);

        // 출력 영역
        outputArea = new JTextArea();
        outputArea.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(outputArea);

        add(inputPanel, BorderLayout.NORTH);
        add(buttonPanel, BorderLayout.CENTER);
        add(scrollPane, BorderLayout.SOUTH);

        // 버튼 이벤트 처리
        addBtn.addActionListener(e -> {
            String eng = engField.getText();
            String kor = korField.getText();
            if(dictionary.addWord(eng, kor)) {
                outputArea.setText("추가 완료: " + eng + " -> " + kor);
            }
        });

        searchBtn.addActionListener(e -> {
            String eng = engField.getText();
            String meaning = dictionary.search(eng);
            if(meaning == null) {
                outputArea.setText("없는 단어입니다.");
            } else {
                outputArea.setText("뜻: " + meaning);
            }
        });

        updateBtn.addActionListener(e -> {
            String eng = engField.getText();
            String kor = korField.getText();
            if(dictionary.updateWord(eng, kor)) {
                outputArea.setText("수정 완료: " + eng + " -> " + kor);
            } else {
                outputArea.setText("없는 단어입니다.");
            }
        });

        removeBtn.addActionListener(e -> {
            String eng = engField.getText();
            if(dictionary.removeWord(eng)) {
                outputArea.setText("삭제 완료: " + eng);
            } else {
                outputArea.setText("없는 단어입니다.");
            }
        });

        printBtn.addActionListener(e -> {
            outputArea.setText(dictionary.getAllWords());
        });
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new DictionaryTest().setVisible(true);
        });
    }
}
