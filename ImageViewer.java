package sec03;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class ImageViewer extends JFrame {
    JButton btnprev, btnnext;
    JButton btnFirst, btnLast; // ⭐️ 처음/마지막 버튼 추가
    ImageIcon[] image;
    JLabel imageLabel, lblTitle;
    int cnt;
    String[] text = {"영국-런던브릿지", "스위스-융프라우", "이탈리아-트레비분수", "파리 에펠탑"};

    ImageViewer() {
        setTitle("랜선으로 떠나는 여행");
        Font f = new Font("", Font.BOLD, 30);
        JPanel panel = new JPanel();

        lblTitle = new JLabel(text[0], SwingConstants.CENTER);
        lblTitle.setFont(f);

        btnprev = new JButton("<<");
        btnnext = new JButton(">>");
        btnFirst = new JButton("처음");   // ⭐️
        btnLast = new JButton("마지막"); // ⭐️

        btnprev.setFont(f);
        btnnext.setFont(f);
        btnFirst.setFont(f);  // ⭐️
        btnLast.setFont(f);   // ⭐️

        image = new ImageIcon[4];
        panel.setBackground(Color.pink);

        // 이미지 로딩
        for (int i = 0; i < image.length; i++) {
            String path = "image/img" + i + ".png";
            image[i] = new ImageIcon(path);
        }

        // 처음 이미지
        cnt = 0;
        imageLabel = new JLabel(image[cnt]);

        // 리스너 클래스
        class Preview implements ActionListener {
            public void actionPerformed(ActionEvent e) {
                if (cnt > 0) {
                    cnt--;
                    imageLabel.setIcon(image[cnt]);
                    lblTitle.setText(text[cnt]);
                } else {
                    JOptionPane.showConfirmDialog(null, "이전 그림이 없습니다.", "경고", JOptionPane.WARNING_MESSAGE);
                }
            }
        }

        class Next implements ActionListener {
            public void actionPerformed(ActionEvent e) {
                if (cnt < image.length - 1) {
                    cnt++;
                    imageLabel.setIcon(image[cnt]);
                    lblTitle.setText(text[cnt]);
                } else {
                    JOptionPane.showConfirmDialog(null, "다음 그림이 없습니다.", "경고", JOptionPane.WARNING_MESSAGE);
                }
            }
        }

        // ⭐️ 처음으로 이동
        class First implements ActionListener {
            public void actionPerformed(ActionEvent e) {
                cnt = 0;
                imageLabel.setIcon(image[cnt]);
                lblTitle.setText(text[cnt]);
            }
        }

        // ⭐️ 마지막으로 이동
        class Last implements ActionListener {
            public void actionPerformed(ActionEvent e) {
                cnt = image.length - 1;
                imageLabel.setIcon(image[cnt]);
                lblTitle.setText(text[cnt]);
            }
        }

        // 리스너 등록
        btnprev.addActionListener(new Preview());
        btnnext.addActionListener(new Next());
        btnFirst.addActionListener(new First());  // ⭐️
        btnLast.addActionListener(new Last());    // ⭐️

        // 컴포넌트 부착
        add(lblTitle, "North");
        add(imageLabel, "Center");
        panel.add(btnFirst);   // ⭐️
        panel.add(btnprev);
        panel.add(btnnext);
        panel.add(btnLast);    // ⭐️
        add(panel, "South");

        setSize(500, 600);
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public static void main(String[] args) {
        new ImageViewer();
    }
}

